Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777A25204DF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 20:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240343AbiEIS7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240321AbiEIS7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:59:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9CA2A265
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 11:55:55 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 249IGUSo022886;
        Mon, 9 May 2022 18:55:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qtOyhrFejtrT9oYLuITN3aicYSgESiIZu1pjv0Vj71o=;
 b=b3ElAPJYlWveUj1pb1pAEomjfj9GO+EZBs4gA0YXuAraKSoRYO8yYRNdgNhvOmzJgRN6
 6ljuSfHAKjUGMe9/Uhms2y7v++sPRXTurx62oPPE95kqNzLnB8mgS9QfoYRwm503f4Uv
 A1RIgIEIJTmA9luem4a74fh+PEUcZry3EV1OVf1bR3SrlSF8hGNcqFxWFw2R3M4mDTfn
 GhfyTm69ETns2PHncQ5LawUCLPlFFZy/jmBxpqZhLMJuNLKdssc+vqTxwzXwmb8fU/zf
 Cvzhm9FY/hm0GaoYohuj2XbcR+H+/TOYCQG09lU8qMllgBA+xEelxo250i5ohNnQw69+ 5w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwhatch1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 18:55:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 249ItGH6039920;
        Mon, 9 May 2022 18:55:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf71bxp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 18:55:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2UF0NnonehWASYEOi1/ai3ND0HZecccxImzkO8FoXX+uGVlz43HfM5LW567nkL2RXtoECJ3utj/yqCyYZ3KHB335QCEPmhNHajkEQucpKgDOOf7IoydzeRucDJc/ivQyCTJ4BBmGK0dEKaLYY2HWrGEAD/0WuKOLAA/S2Z5rewIjgYh0h37Bhu6WEdH/Lowk+UUQsdohm1b6rR4nqwV0cuK9/T773z9P3JsX5xS7Ggjd0wyMvNvtdledoqko/42QUaqVX92G0x17Y8hfXnKZzKspy8O2XJPl6AR0xieDHZf2qyut4P3bSXm6bAjy7ZkWOgxJrvpzmDUZyQ5Th0u2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtOyhrFejtrT9oYLuITN3aicYSgESiIZu1pjv0Vj71o=;
 b=cmxWtr92I0Hj0UbAZ4mha2zxd+as76QziIiMyZnyXf+n9vPgIyJnPymvkjh6keVQpOZ31CnKWU0Mm/4p6KhjmQ9AFOHVLzsm9dWtueEJAYHzjLLASPOFSJw+KeoNqgsBWAI0X/F4ZXk0WTPs+OAM/4jOol/rPJ0gkgumjeKA0rebcFhcpiskEYgbke1sWVHTDvsZRdAnBo/WekhQLo9OyWvrH0+IUjYbV1a6gc2rRsQ++DbjlbP6XwUnT7xRlU/HJhSYu50eBmP0PKkV3ht4fipMhYwsGLGi94NwnMUcAqPLodGew0U3wOxm6zUTdkXTqTJH37184rTs6+REej96Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtOyhrFejtrT9oYLuITN3aicYSgESiIZu1pjv0Vj71o=;
 b=ZIc2cXyvQeKBQqoJertYelSCUIUsXenCfR/pjZ1sCZEuXLUr6UFQUPEdyMdjOQgGvu9bsa/L6qpWl2knjmskO+Q9qoV6MdF6HkG2HQYMlBN13yV8BSeA39htE1vnm0WLW9jLsYghVE6Wl0/t0wRy1iYlsEJ9wrE50blxZysGn3A=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2749.namprd10.prod.outlook.com (2603:10b6:805:4b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 18:55:43 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 18:55:43 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 00/69] Maple Tree v9
Thread-Topic: [PATCH v9 00/69] Maple Tree v9
Thread-Index: AQHYX1NY7mnX6OfbA0OUwkg2Tm0KvK0RImcAgAXLoAA=
Date:   Mon, 9 May 2022 18:55:43 +0000
Message-ID: <20220509185524.p5hqqv6jqhql4sup@revolver>
References: <20220504010716.661115-1-Liam.Howlett@oracle.com>
 <20220505192518.72ae9ada349f2880ba90c3e9@linux-foundation.org>
In-Reply-To: <20220505192518.72ae9ada349f2880ba90c3e9@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d672b4c-bb9a-4afc-fa0b-08da31ed84ce
x-ms-traffictypediagnostic: SN6PR10MB2749:EE_
x-microsoft-antispam-prvs: <SN6PR10MB2749F31C6C7924999E914C65FDC69@SN6PR10MB2749.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8xSVFBM7f7nd01VpjUAh73mxW7uEF3iBfXP8RVHfNUu3Idk4fZij9OXIKXxYY+I8svT0EMxonY74oaG5ipfh/7uVy5szU87E50p6p2RAhpuf+qemkt8sTECJROoE4cz/lqA9GilVFJYwdP5YWLZpATm8qW880w+Sy4tCyuwj13wXVvtFoEXJnDAzxpDNf9tT52k6cv7NybA+AwFI/Za1kyG5z1giBgvh2T92LXK/ShSH+lCrAJbJaigtha3C6Ub9cvRb46DG69rNG0c9ipLiJCEuh6Qr8OZ7HnhoSBlF/4F/pmGrxbWJUfykl6wfJLhVs6CGMI1WDrIBPJgXpCSONTlq+YGyrlDtv2TKgtBWK9ZceVXRtx6HuVYVtEM/LQpKSntnET6OH5UxEa0wqfQ+sumDILVMuJjnasf1nGBfjwRV/1QWl8kN0d8k2ruSlmhnTJAekPSTD1n7a+/FM68rx6wpWpsUZxK2DIa5qj4LEo42tmrS6b89SwsX3jkpqegFez+57Pc5vnbJ8nhKYJ3Cingom3hdxhx45lVCES5KfWOf2V2CcgfzcVcROzKorfhYygWGBVTUca3GNTaOPc3i635mYpw0WDgPTojvVFXuknHozqxKQRde1S4sf2s+0bGUpYWJcq7ArHMu3zgBAmtKZ4CTKqs3IvFpwMennNbmLmz9+X5mI6eddfjh57UxCda9JtvulpQXp3nchWHn1PbhWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(86362001)(71200400001)(26005)(91956017)(64756008)(66446008)(66476007)(8676002)(66556008)(76116006)(66946007)(508600001)(8936002)(38070700005)(186003)(6506007)(5660300002)(4744005)(44832011)(9686003)(2906002)(6512007)(4326008)(54906003)(6486002)(6916009)(33716001)(122000001)(316002)(38100700002)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?311D9QE+MlCB8g9ajvEIbbHBEeFn2b0SyW5ptpLBoNQawCjBaq4scwZ29jXS?=
 =?us-ascii?Q?rN89fir2TQeSnavueMTa68/6GLNAwpLfkwUcZfulrf0B9+ERhg2MlLFRlQ9y?=
 =?us-ascii?Q?qatnNdzInozQPZhHscp2wgY3oq3FtRjOzptFdTnyeENLaZq1n5sIMq5UoDhs?=
 =?us-ascii?Q?S/+mqLeXqv6M+X76Y7Y+ahyAueomxfsY91ZnMS98vP2xa9TPrBUwsKmrVgZ8?=
 =?us-ascii?Q?+sTtQOa0f7rjT3tiKvxOQIErVAdZipZIzQVzR9tnaUpqK1ZQYcLpvD6K9jU1?=
 =?us-ascii?Q?Ft/KqPWQ41lG82WjveolKQ49FuxqJUWH7i30ozrwNToUDFSFIU/vKQVxtbwH?=
 =?us-ascii?Q?aEPWP94REWYQ95QbXhOJcdCPM7+9rihJegkbBpEPyq11juyiSLcAv1iW68Sr?=
 =?us-ascii?Q?fmzj7RbhLWcueOjN7cXlClUuQs8SChSytp6nLV3OFG7IxLWUPWiSMjviuq3P?=
 =?us-ascii?Q?T+kbscv//ggdNC0zeHHG5N/x495AE1/hlFFJMKBBLEoOW45mcqMWLwzcWbLw?=
 =?us-ascii?Q?Qu7dEfl40c8FH0rNaAKzWtE/1cwQ7e85JxwFZkd6hktpvWB+4n4Xx+qxlMP2?=
 =?us-ascii?Q?TbvHNWZ9GsuG+GpgW8TUT+Np2RADplcoL6z3CbQrfVkHEON4nuiEpNt4QHhL?=
 =?us-ascii?Q?a1n0q9NjkNsTVSjZpzeBgT5fCV8AfPOEvyerpcnAJJNfaSffZvW8+d3eIerZ?=
 =?us-ascii?Q?JsDVu+f/OWM+SAfXxbcrAF2p//WgnrvnKD31UDU51kxpYXZ7Mld4X4QcUhyt?=
 =?us-ascii?Q?KDeEWw/gThjIxblcaFuKqTngJIbUZE0yGAQ0fGw3HjHVqo085GG6TftORi8h?=
 =?us-ascii?Q?SLW4JiLsKJWzFnYHXo2kCNCRAvgjM7F8yiP1pN9WZ7FuJFAcb5lr1Nt9QPtW?=
 =?us-ascii?Q?c1T24uAV0bcXQoc1U89GhORohL4yEqi6Qdo9PNGn+Y+dEeuUOmp0vHdK7lOB?=
 =?us-ascii?Q?+K4+QuZvCMijJhwbtz7AGsKcuW1gCLYfCUAYhd3jnKuLBCjJstMbg1FgDHX9?=
 =?us-ascii?Q?FaptG8q3xP4AAaevkxcD5bP1EvzsGYdqHN+/PVMlM5O8agw+zfRk/8mcBbbW?=
 =?us-ascii?Q?KmbBR3TbgYfsY854jrLY99suCeI7zX8G5z12MT/UAT0i+pzTnoyKhZg4KurN?=
 =?us-ascii?Q?7bDELCdGw3Pb9mOrvgTWHykvlfSMSmGk27VZogn6KxV/5tks9XLYdbTSXyvP?=
 =?us-ascii?Q?1r+vzXiKYOuxT9XQIfrHuFhXSVw72MQNjHdG8JvUf8xLj/b/xyNrJE/8bbbF?=
 =?us-ascii?Q?thzfukWGXnpu09/OuwJSs+MU+syPv7tQ/di7DSZN82iwgbEou54KwX8PfcTE?=
 =?us-ascii?Q?fq/VKMjGpU6H5I2loNih9C2ZZPjsjO5PLlvuV1JzMnQO4nRdiW4PiRYwiaI0?=
 =?us-ascii?Q?0na+sS/itehNXJ48G7Faba5bFFiMnqRovbViPgXaAX7U3j+smOCHGYhNfu/X?=
 =?us-ascii?Q?PgNZPQyogeBS1Cup7Nswfv6jqm9SX81Az2FBWs44DsB1C5Mp5iYWe+O2nA6j?=
 =?us-ascii?Q?6LDaI99jRM+qSX1ZEWvcHI//Adzn4NhKEOYrahg7XPk4q7aVeDPf/kh7yD4I?=
 =?us-ascii?Q?Y7wYOTYisopLlPLRrVEC9mBN9i1Iaw/HZ0m2aR3zPsY6KpdNu1u28PeGv+4J?=
 =?us-ascii?Q?4laQ+1jp9mz+pAaF1piaDXXg79xHxvf6crf1NgfVx0xquw2/012OhK91t2HE?=
 =?us-ascii?Q?Om9XzGfo54Klm9XFlmHgVQRuV/joBti1nCsF5IIRi/7BIAV2XcTx0BsyryMT?=
 =?us-ascii?Q?8cp9h9/TYooOPL1+aHrqh6f19aVpeu4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <36672BDEC00D7E4BAB7ECDC063F7B9A9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d672b4c-bb9a-4afc-fa0b-08da31ed84ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 18:55:43.1044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LKjhonLwJBFLQBc2RowrgFch1sjEKTcsV36zfofyCcwoiJfDFyGG7HHhRfggTzzdKImj4fimr7KWBbp+kcLc6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2749
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-09_05:2022-05-09,2022-05-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205090100
X-Proofpoint-GUID: wpbKZTHscmwRTKG3ahQj-fU6NuxInj4r
X-Proofpoint-ORIG-GUID: wpbKZTHscmwRTKG3ahQj-fU6NuxInj4r
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [220505 19:30]:
> On Wed, 4 May 2022 01:07:38 +0000 Liam Howlett <liam.howlett@oracle.com> =
wrote:
>=20
> > Please merge this patch set into the mm tree.
>=20
> Well that was kinda confusing ;)

Yes, sorry about that mess.

>=20
> I have it all landed and compiling, thanks.  I'll suppress the usual
> added-to-mm emails - an armistice in my war against `d' keys.
>=20


Which git branch will have these changes?

Thanks,
Liam=
