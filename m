Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9FB54E928
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 20:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357523AbiFPSH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 14:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiFPSH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 14:07:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F13D3465F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 11:07:57 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25GFEbuY026656;
        Thu, 16 Jun 2022 18:07:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=HuXbTYGTeY9tiJ67M4QRkJ04BUAHpX7CS9CdSKc9yz4=;
 b=W1ObI86akK5qo9CFWtDjtM3ymXr3++tuAVtAui9u79Ck46Wt7UTnXGlH/C9goscKbgq2
 +B5p24Bwxbr94uGXjYgxpJWEI42SsCeUFLdDImRtvIEZsQ+vkiPMGAS+EF8abxOYaBD0
 +vpErBbDbNPkblHqiiba2hfnD6KcqVn6q5tD9zHPQkToMO4J0qRi2CzjKT7uHbdk2y/0
 dO4A54w58QMpX6twjEvWz6GFBTDmVqI87wHPSIHCzBDB48cQluLvlqkzKkfnT7At7zWJ
 bZMA15mTK3ZNlJiO4+kOFIjPFq8RxulYpL1q2UBYX8AUasQpNweyTD3YCMWrTfFAeISt jQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhn0m2f4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 18:07:55 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25GI6SkM010492;
        Thu, 16 Jun 2022 18:07:54 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpqq2nww4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 18:07:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBwYibUqSDD5GfyVvEvH8OH/vM0uy7OzsvfXV0zGGocXWw4sQ2P5icYz/cexA37weEH9zU46e3kfSIMa/PZEC3q6JYXykn9p4bgSdZX8YfaOpT7UF75PA23Lrd1mnGKF/iMqLbOyjneqAX56CFTXa/nQp+dskOM27SUH29JQCvRNT7+5ILHyAnLZ2Lx3MkT4lQHBqpxedQC/GcMpaARnRYY2TnpK4g8ARssdZ/N+4u3vVma5/Pb1omjhmM7PhqvJ/CZQKhSiARVD8jGHRojEq3ulpvyfHXTYAX/V3GfUC4QrNCiFl//XVFxv9UUZSTqePZIu2+at9aZ4grLDJmycxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuXbTYGTeY9tiJ67M4QRkJ04BUAHpX7CS9CdSKc9yz4=;
 b=E0jvXPHO5p2EIHHSmP/bI9QwhdDrwML1G3WJWKrJt1FlGPrzJ36HRleIEmgYqmUjIYPphvIQTHrrf36rlEORF6B/r+ww8quf+jaT8HqZ/XUbSmpZaAFzUU8xE6xMcAffiQ1zryxxTPdZAFV4U6U1/h1O0nYswFd7uh2niP+MEEUbz+p5SfT7wSeyF69uGjZ9PDyhE82frWgcOsPMQxupMKSuqczQzQq+IHX8c0pcm/K5KIcLU5eZVuq3ZMz3rHbm8Q8jzSo2dMGwDMz6jwSVyQv78OlHOSpRx3WgcidmcACkglXzwDSnX4EaCxbguoh77AUCPEJkG9Etk5k7GlF6gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuXbTYGTeY9tiJ67M4QRkJ04BUAHpX7CS9CdSKc9yz4=;
 b=Kvs45hib1w3sKh74w2YY+Ufgm8Z+28nyFm4wY/QVDCsyNN72/v9jsNZaZrnd2mS8MKKQuMg3GFDhCJI7oikYkyJP46cgeOFLJZ6gfr6KiMyrkkO9bBFu5MeJyfzKQvMhmunwQypydl1tFS538fJA7tb4+cLqASAUaCJobOE2+wI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MWHPR10MB1693.namprd10.prod.outlook.com (2603:10b6:301:a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 18:07:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::a022:c9:1cd6:8ef0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::a022:c9:1cd6:8ef0%4]) with mapi id 15.20.5353.015; Thu, 16 Jun 2022
 18:07:51 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: possible trace_printk() bug in v5.19-rc1
Thread-Topic: possible trace_printk() bug in v5.19-rc1
Thread-Index: AQHYgZTiaV2APa8LiECz6bYrBgXq161SKdYAgAAAwoCAAAH0AIAAKEUA
Date:   Thu, 16 Jun 2022 18:07:51 +0000
Message-ID: <88ADA44D-E457-4DA4-BD65-73F583217363@oracle.com>
References: <F6C267B0-83EA-4151-A4EC-44482AC52C59@oracle.com>
 <20220616113400.15335d91@gandalf.local.home>
 <E309A098-DA06-490D-A75C-E6295C2987B9@oracle.com>
 <20220616114342.3aba84ac@gandalf.local.home>
In-Reply-To: <20220616114342.3aba84ac@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: deb54420-1aa2-4f47-0a65-08da4fc320a5
x-ms-traffictypediagnostic: MWHPR10MB1693:EE_
x-microsoft-antispam-prvs: <MWHPR10MB1693B00BB43198D00955082493AC9@MWHPR10MB1693.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zONnYQraFJd7+L6tAJ9RrIT4kbvR5aEX1+wJ5bG/WbipboGTFcm0ZHQXz6C+Utp02papOZ54clWnqcZpxGyQY5HW0gGPrki//jdBpkPLzu/r52JQFPi4A1cvB74Wj0j7Hdmy1y7SMmD/1vPBleuwiR9400gd1mjDpVj0LzKamLGZM+fkOGVJpz5I+/GdO89u2IwGM8ve6TRlgbX48AxGxkHx9WJeWLiXy2Dhr0h5c2gh8A0GQlI9JY+3BMIHwPfejUschqbL66aHJK/W4M9nxfjc2USp5pOjSokzc4Z5+ZtK4Xh1A/q6Q36yhmkLVxneer5J5QKLNycPJ6/wx5u0Y23jwHVBAJJcgfBfCWN6Q0w1DQnXEoCdhMZRg/T0N2IvhwMmMfkmRakcTkWaxtots1m81n11+4+R5jX4T2kHYypHrhA67cmSKxtjjHR7mNb7ghBk67kQFP/HLi7mpA/NCbl3zBqCGzE4Kf+hbn67ucXNEAkZngf9ozscgBEE0M09uAEeGMzMlHs41hPKHmjbPvtSegVTqoHD5ClMiiexJeBEYfOorGvhQhtf3guSpQBTjkuPH24MSOGXOU/ajxUX37COdKZUXkRG6nS45E5o4+MEqKYV+PP4AP6wV2j816LNqklOL3mSbfl1/i8AUmMPwlmqjc07h1t8RhEKH/ZJ0KsSFLg7igFRoRMU1G5dOxZqnh9pSfUZ8yyx3Ozj423hIUSZfkpIe64+y/qBw19fSqgvzNzyuH8MMxzN1LA+tT6Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(64756008)(2906002)(38070700005)(122000001)(66556008)(508600001)(66946007)(76116006)(91956017)(66446008)(6506007)(186003)(8676002)(66476007)(6512007)(4326008)(316002)(26005)(36756003)(6916009)(38100700002)(53546011)(33656002)(8936002)(71200400001)(6486002)(5660300002)(4744005)(2616005)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zBhU16XwBjS4kVVnFYbKniBmhnx7vMF5PJBdhW+zXODudNxKmR1vkpC75TAg?=
 =?us-ascii?Q?tfVVM1Df3+VcqQSSU2hPB3QFLK8Ri1JwrT+aTEk9x+MZV1d2gRDRB6YvVll4?=
 =?us-ascii?Q?3jyFqhd0X40mxm5M3Du2rqLJNyiWUFXrYIpHpYA9HnygrGq7W2mH/XAuaELD?=
 =?us-ascii?Q?KCRdUnb4dsVgrf4dR2kjwEZTbT4DYI3k5zpQNfkwjQYHe02pjeFJ7s/XzKo0?=
 =?us-ascii?Q?ZbsL2aNT1ne5485yXi89EJOdnEZxmsVwi5NoVytMTmrKfE+YktMLmQg1tfY1?=
 =?us-ascii?Q?rK6Hikj3Tg994mMpcnWznh0YI8yJjKBB59lNtgdaW8bGu6fspU2tWGvgOLqM?=
 =?us-ascii?Q?B/BGvvp+cZ9Tj0U1r+VM3uPEI8danZeQ81DEaQGf6yHRM6q8/zIeyxRGvkgm?=
 =?us-ascii?Q?8EnA/CzUBe097wWCyi/bjtD9tk/71SICRehKs36ZjWytmX8qKYRhGHd1wkQd?=
 =?us-ascii?Q?IfMwwEh6dAdKXuK7hV/dGpxDL+HDlGnlqfGElawF6ul50UnVCWIH5AXsQqVF?=
 =?us-ascii?Q?J3ZKqBpA2fMfkC6qjbQpNzZxjVkSAXFrnYre2dpMajo0OVQkyYrRyIae1TC/?=
 =?us-ascii?Q?X64ZAqz2Q2/1RNypp0AwGvZdXphnz7g9zutSD3jetibapJd2EXbTpt7CIkRR?=
 =?us-ascii?Q?OZmTtwk25jJJW5BNRXOQFZt7j1yjazCeSMN5k4FQN/dvQP+iaZs+8eN0IZ5M?=
 =?us-ascii?Q?XsGf5kTGZFs34i18Zd4vXhe6mxKCjRGmRwvFORp6ziC/JDGlRqXy+nRBOkr2?=
 =?us-ascii?Q?LCvOYj0Dz6yqrC8pvjiFgOipX/Zco6z0Yip/1CPKsJaDerNP3xBNUPPKLJWA?=
 =?us-ascii?Q?SG1zA49i59beiqVhorP80nkpM2xTKYA1KXVpJrTTK4ealm4Q+nJUffA0pMA1?=
 =?us-ascii?Q?0N767xGJzdyp5Q6WbXydov2C1u4EbRc2WnIIdZvUOdfgMOfRvttvLngLeXOy?=
 =?us-ascii?Q?/y7rk/Hlnvz1efrU7HSvJCw5KVM79UM1E0SrOsKfc8ya4RGkMvVvasxEWjiJ?=
 =?us-ascii?Q?b6cwTR9cyWoJGE200FbfCb9HhODOP6DLVoofptTwh6qjy5vippSoTw2F9w26?=
 =?us-ascii?Q?hqi7pjeK2XNVEEi2lgdsQr0OjKvhPxx+J8BOyknhT4ux+/GXlgFR0LglYvKU?=
 =?us-ascii?Q?Qn7OK5tzvvx7YHdcoM3y8ujWr9oEx//Zjm8J/FM9GmQRFT+yO7onx0HSwl/R?=
 =?us-ascii?Q?WVk9Mya+XHm0II+1gQPT29mqwsPw4mxBx3ZxfhjHv1/z9Sk0nmxRYvRJQMPB?=
 =?us-ascii?Q?sQi13GXamMDU4OeynrqDelivXdnSekPUtimmu1k8a1V6qP5/S8LPiLCyARnb?=
 =?us-ascii?Q?qZf8OUCgfZj7IebdxLzh58cY6MsGu6q/RBgJuMQ9RqcPeFXE3F4hQyQgrACQ?=
 =?us-ascii?Q?TQHfoIWIYVxTp0sCSrQWGrQ6sWZYZbGHj1onB7Sji9daO+i/l1oa7KbKkplU?=
 =?us-ascii?Q?wzHsl/nQvQke0z8lkpvllXiZS6bxk8SLbLsZgEqSqjuV8Y21OldyV63CTPv7?=
 =?us-ascii?Q?yx/L6FbmC2XpDbhwR7cHtHBrYIEpAz1QXzD4NLHi99EzsSHkdOYSIEpOOTGJ?=
 =?us-ascii?Q?QzziFZJfKkrSBXxRGWMSkmT5jboT+wpyRVkOh54pVEeJvy4kBZSOnrVF6FMo?=
 =?us-ascii?Q?riTU/j9HVaq2wfryC7tmNYcw6z7UEdAYi6aKhUm6b/QsLtzY1Wg81ZNVpv32?=
 =?us-ascii?Q?UgNw3AJKPgBkbNL3uIpb8sY03ONRJmlaGq3PTn1LTyXvRfSi4bzdJ7MMrU2J?=
 =?us-ascii?Q?CfTq138uJ5GC+fDt70TrqMeClrbNDMg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4922D1FDF9C2364DA4EC49422B55146B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deb54420-1aa2-4f47-0a65-08da4fc320a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 18:07:51.0625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NMCZNXUuSyvS/olTMrQOeYygnZ3vZ1lnFXrvZYiFruABtEOHzrRsO5qc0qDaVyussav1YwviqqdWjsFpMJv+TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1693
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-16_14:2022-06-16,2022-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206160073
X-Proofpoint-GUID: F2QYPYwTYUSYPhFWpZ7IByAX437X44Ou
X-Proofpoint-ORIG-GUID: F2QYPYwTYUSYPhFWpZ7IByAX437X44Ou
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 16, 2022, at 11:43 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Thu, 16 Jun 2022 15:36:43 +0000
> Chuck Lever III <chuck.lever@oracle.com> wrote:
>=20
>> I haven't explicitly removed nfsd.ko, and lsmod says it's still there.
>> And, trace_printk was working as expected on v5.18.
>=20
> If you were to add a printk() with the same format in the same location,
> does it work?
>=20
> That is:
>=20
> 	printk("%pS still here\n", __func__);

Sorry for the delay; lunch was mandatory-to-implement.

This code:

	pr_info("%pS\n", (void *)_THIS_IP_);

generates:

Jun 16 14:05:53 klimt.1015granger.net kernel: nfsd_file_slab_free+0xb6/0x10=
a [nfsd]

--
Chuck Lever



