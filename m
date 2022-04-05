Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C804F51ED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1848722AbiDFC2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376690AbiDEV1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 17:27:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B5DECB37
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 13:49:04 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 235JGpKa005378;
        Tue, 5 Apr 2022 20:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rD9LFpplLVbNF5/+QbOgrnpBtJCOFwy2Ieh90dtvNv0=;
 b=AtDdATblWMxJzVReBPwX0YRZM8B7zEDPiInNx6RiCkvMoWl2JorLXYig2J4DI2/D+YQc
 cNXDXldOPze5pEgHxMYFEDSNXu3uYHjEVKu/NokIwrjqnTnpOrYd+aNNTLkkHQ3u2l+G
 WkyRvhPJ2r8Rayc6g7ydZq0btwkLBq1eSZ9SfFvAgsIYwU8Yoh0o/sGPoxnT0yFYp4+g
 SsTjX6ZhEp7RUrR/w82kwwci0DEHf1rPl9/cN8hauckYvxvP/OOlMxuCj7Q3sWVRmDBw
 ESpzmDXpj87Vm5zuQR+4qo8zubY2nuIlUggCCPqZ2pA90xDSQBDBsyOwxe5H/oLEhJGi DA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d92y6s5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Apr 2022 20:48:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 235KjfiV001594;
        Tue, 5 Apr 2022 20:48:34 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx42syv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Apr 2022 20:48:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQAvszyGRz5y3TqnOE+pXJcNDqYn4nP1wa8pIQh4jeY4gKbfhsEUkID7RNhqUDkix/wmPAStMj5ltexzpK7ppOD1EuSoLQ0gSUDxxRqeNgoWCF1Q4Q+wEK6G+LdY1oW2Q7DUd5tIkSsjDfVdrjCdFqK/mtniEsPYhWdxyLA5gjbqDO2fhFXfHxll+juZj/c5FkHp3rZ/H9C14ABkIb5EYiCUMW4EDnCH6psX6cmUFr0L90blqXdP4uo8ZeXPtr5/89aAYCgRKW7Kr/QEk1rCI/S6uBXfleAPuUp/M7eNrGgnOazK4EfiL6xs7anJBnwImCtaFjIT5GyNRcU2fHFw+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rD9LFpplLVbNF5/+QbOgrnpBtJCOFwy2Ieh90dtvNv0=;
 b=O4M7wMqKnqtPkOCpmtYyxZ9RlGyeOSv2pMcDYXD+EuM4r+XIbdZUDYbjbMJo1VTOn+xlu0fZeq2JvG+xHKbBBuoNMu7/3kUDE7FrcJthDr5RpjGoSLKNfjAWVnBjP3ZejV7PY7+z6+kC9/32TJkI7Il1/IHT64jThgSrc+fq1hopY9wS5MOSyfFc4KX6+b1oy9Ar9Qro0oBfu/iaM8l1vyQt+9Far1lEkwitvAel5skJSn2YyeO96iasWh5IQeD3DzNu0uGuSa+woSGPR4yH8Rf7QWxztHtdGNMhnnZSdAgf5nHIwHOO3ugHyOXEh1kJGjUEv1EsGp2sIcsA27R99g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rD9LFpplLVbNF5/+QbOgrnpBtJCOFwy2Ieh90dtvNv0=;
 b=BA6MNXpXUoYUlqDjoTzrJExff1rPG8lwCG3HBR89cSeGy4XPkTmu53SwdarzpHnoVdQzqbfMp/CQtmMSpflsb3gAR8hHid+ndTuH5nyXBQjn6ctM8EHwLNuIxwWjDfjI7IcFHrgzpsp8S0xwxpu6hDqy5t+VFWazXqmVNrRJ0/Q=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by SJ0PR10MB5786.namprd10.prod.outlook.com (2603:10b6:a03:3d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 20:48:32 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::19cf:32fa:454f:7bff]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::19cf:32fa:454f:7bff%8]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 20:48:31 +0000
From:   Alan Adamson <alan.adamson@oracle.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     Yi Zhang <yi.zhang@redhat.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2)
 MORE DNR observed during blktests
Thread-Topic: [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2)
 MORE DNR observed during blktests
Thread-Index: AQHYR2cuTGHViq1YXkqwVFy/Mk48DqzhwNSAgAANYAA=
Date:   Tue, 5 Apr 2022 20:48:31 +0000
Message-ID: <F2ACCD82-052F-473F-9882-1703147FA662@oracle.com>
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com>
 <Ykyf5Zuz1W8yHhNY@zx2c4.com>
In-Reply-To: <Ykyf5Zuz1W8yHhNY@zx2c4.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce428fed-616d-4a12-a934-08da1745a54c
x-ms-traffictypediagnostic: SJ0PR10MB5786:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB5786ED139FB1EEB29FCF8246F4E49@SJ0PR10MB5786.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Knb2qrbYddAkaiep3nujtCaK0fx4bbM9LFl57O770T3sv7GUmWCXDzoSas2qP/+d6SKQuKctI6Ad/vCDlhGormY/mG/KXnMB1l1I1JdUVWeK1JDaeJGoA/a5ToksMurDBJYhhNyZOYByNiy1JgpKbEHUc53PUPFZ/XsOcW2n+iw7qXbeTL8eyE0fUdTZAbprl+nVgijO3F6snC1+GG6Vj+gUzMY3U9fHnpv669pjOmje2SfTSIbRMdLilPki2DeY4iW/TGqL/sTQgdW03siekF7NwEqNNk0GIqBzNSlFRiRc/MIcYr5tC4QPUfV9e6Yz/2nUQI09Y1uZyU151fVERDImKaLpNcpz2PXPQs46uI6iaPaDzuCxwWLFTrL2mROqGDnp48rTD58N8hMZkoEyW2Flo/c11zEgQ0jJa4QVa3ZPSvtCz6xzaHZZhBxelZAl9gGMtxPkSSEw+P+QrxeAmm9MoiipDa7SLc9K/UsOOd3mu+eBvDpDF3LWVni5gB3UGm0KqoAVR+M9CebyO3xSsyi7FLwxFk25Lx1aIbLXluh8pzq5WJEID3nVvMxI8UIOm7ZTOMSh0Ojmi9XIJqWbC8Mb1Whj2HDJ1xZwXvnOblb2q68P6nC8sfDe5cBr5ROJ9SVvLm5Ljp7teCCXDAaxvDoggOaQEEOBFB5Qpi9aj/xVzZt4GEfKmWQjVowVjOL8AO8lJPMtIsB7wQDbVKYLp2aIWAQDtJpcE1x5QF93B6rIdrkTzcrr+TouXyNGwShA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(122000001)(66476007)(33656002)(8676002)(4326008)(66556008)(53546011)(66446008)(44832011)(2906002)(64756008)(66946007)(6512007)(86362001)(6486002)(508600001)(38100700002)(5660300002)(2616005)(71200400001)(38070700005)(316002)(6916009)(8936002)(186003)(54906003)(36756003)(83380400001)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekNUWWVwcnJ3TExCdWVuUy9yaVlzcmY3U2t3VFpiSDBrajBpbXVrZ0IvS1FB?=
 =?utf-8?B?T0hxbStzV3VBM0QzZjZsUzhQRGFNa2F4aGxvU0UyUDVKYTM1VEx1S2NwRmU5?=
 =?utf-8?B?bW1ibWI3YkUrdHVaSlpHdFQ2OENDQ3BjZFRkRDBSK0lDeGJOZWx6SDUvWDFL?=
 =?utf-8?B?cUNzelR6ME4zdURIUWErZVRDNzVoRWpIRVhHenF3ejA5K0xqMWd6aW9KTHd2?=
 =?utf-8?B?L2VrNFhaMFhodmVRRzZzcTF2bmRGZU9TRGJxbEI5RmpGdU11azQwbTcvNE50?=
 =?utf-8?B?VzVlcWJIbjJsem5wRDBuR2lTZU1zdEpsTWRzb3h3T0RBc0xVS1ZydE9kSHFS?=
 =?utf-8?B?THNQckEwVDRtMjBmS0RGSlVuT3c2WUR0cVY2eFNYVmIvUlRuWkR6WFE1aWcw?=
 =?utf-8?B?VFJJVzdDQXlXKzBtbWZUcEF4Y1pLVVFCYWpBSENtMVZiTHJPcE9kNWZkY2li?=
 =?utf-8?B?NFpVT3JPZ3JEdDJ5YVN2QWRjZGw1MU1HY2VWdVAvL2kwZUhIVlgvV1lka1Nz?=
 =?utf-8?B?bVhQek4yczdYSzRyY2gweGM3Ym1TN04yZmtTMjYyS0lBUkdjZjlIWC9MWWxk?=
 =?utf-8?B?bk1yYk9naEFPVjBmWUVRaFVXQytSaHNTaUQ4bkRvOW9aaEs1dVBXb1VQZG8r?=
 =?utf-8?B?Y2QzZml0VGJJQVE3ZCtxNm4zeGdYNGhybE1nZmhxZzBFQnpRSjFwZklZbEln?=
 =?utf-8?B?a2hNa1lqTWlKRGdLRmdEeHN2T2NaNFpUT0EvRFhvNzdsODRwWGM0RUNFbXp0?=
 =?utf-8?B?alRNeFZRTzZmcTNHRUV6SFJnMkdQSjMxempYdVVaQzQ1MkVUN0NhYWY1bkVj?=
 =?utf-8?B?T2pHWXEyZkRhaURLbFFqUDlQQmlsdXA0ZDdpZDU0dUZ6aEc1WHozOWdZNDF6?=
 =?utf-8?B?VnVWSTV1MTZRR002TVVBemJ1NjExb2N1cUp2emNicUxYRTJzYjQ4Ym1GcXNS?=
 =?utf-8?B?UzVML2xZQmJsYVlVTnFOdmRrK0ViMjRyYk10UGdFNXJ4dE1FczFHWm1MZDNr?=
 =?utf-8?B?alExZXhIWVlIOGtjczVCOUN3RENkcC9jdnErUHRoSGFOd1h0Nmt0Yy9wcGdT?=
 =?utf-8?B?LytJcE5Hd3R2YThBVGF1dXlseUJvdDhkam54R3ZjRTZJbDI1UUpGL1RPbG1u?=
 =?utf-8?B?OXVwcTEwQWV4TDBkNjF6Sk1JRmxOcmlsaXpvMVRwcTZMaUEvdk1ER0tFNzdW?=
 =?utf-8?B?QkdLd1phRUxvUmJZQmluanJvams4dy8yZm9IaTArVVdiVmJlcXFoa0N2S0ZD?=
 =?utf-8?B?cnRDRG44RXM0L2JsL3BuOXRISUR0dndTbjlOUW9Sb2dlaXd1bmlZM1p4N1Zh?=
 =?utf-8?B?eEd5dDI5Qld6L1RNZjFzM0U5REpUV2ZHc0lNZVY5aGFZR3ZTb1NQdHNDRmpV?=
 =?utf-8?B?RlFGRzUzbUxiZlk0Qk1VU3lRV0taaGNGcE9CUlVoY25uMC95Y25XSWtVMDlw?=
 =?utf-8?B?YzkwbVFTVVprNkJkdnRjOEFWckZEVTkwLzJHOVdHR0dJenp2cVlCWUpMWmNI?=
 =?utf-8?B?Z3ZrR292azEwYlYwc2ZtQWZ5M3Nnb3plVmpOKzU0NnRFVjl6clREbElLYTNz?=
 =?utf-8?B?VXdkM040RUtuWlpxWnU1MWZJZmtaTzFIZlV4VEw1ZVROT3g5T3BkNm16eEZk?=
 =?utf-8?B?bFhFdTFzQTJ4czlCTDFzaTVhOUNvNGtSN0p3Z281NEtkdjUvbjBaTFpoUklH?=
 =?utf-8?B?dXlIOGNOZGVFeER5YUhnWHF3SFBWa2wreldOMnVmMjNkZXJJYlU5S3NhUlM0?=
 =?utf-8?B?L1QyVDVJcGp2N2dUOUJ0QVBVbU5odmJ5cnEyVThlV0tsanBJcnBxZGhGem1q?=
 =?utf-8?B?bUtjVGF2VHRkWFZBTXRUZ2RTNUROTVY5T05zclRyWjVtQjFrR3N1VENRdXNs?=
 =?utf-8?B?ZnJ5TXF1RG42UmNaS05NdUtWejY2Q0xtQzZXclBjb25qcXJOdEs0ZXJFUE9T?=
 =?utf-8?B?Y1REZGt1NzV1RE14VXljUC9hbEE3ak51TlJHQVFRSVh6bUNlUCtyZDNsTW5p?=
 =?utf-8?B?QlBIQVkvbWdtcnVQTHd6MlZRVFRGdk44cSsyTHhhTTFDQldpM0FWa1Q0azdB?=
 =?utf-8?B?RmZOdDVrcEJUNmU5VFF6MFVKU0VwdHZIVEpER3BZRm9yWXQxYU4vb2lBTjV1?=
 =?utf-8?B?bkNLOU0wVlBad2pnWEVIN0ZENmVLZlpuRDFCT29reC9VNCt6Y2E4TGZhWTVZ?=
 =?utf-8?B?M3QzQm5SRGgzNnRMVklMTTJkcmdkVWVmU2VNZDRRZDFlVEdaeS9Nb2tpMlgv?=
 =?utf-8?B?RWd5aXFrdlQzTC9hMG5takVEOHpaOWh6eWh6TEI3VzVmd3BlYmdMZ2w3bldm?=
 =?utf-8?B?aEorTG8rTVV6Wk9UR3IwbkpyMnpGSUxIenQ0QUNhZWNpaDFzOENCOC9uQkZR?=
 =?utf-8?Q?XgfGy7FnbdrRsEQCLVdn3C1JIRLdYNxcgufJm9o5/6xls?=
x-ms-exchange-antispam-messagedata-1: u1RpBSTqQPMuQQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA890369B732434D9B66FB06CF3F8978@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce428fed-616d-4a12-a934-08da1745a54c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2022 20:48:31.8543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ixalvl7afPwzjy37JTpD3d1LeUG3bOnhr6CxHlzmtkxzwdGgwrUxEnOn3mB+m+ZS2EK9Hb30hFa2vKONZIn3vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5786
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-05_07:2022-04-04,2022-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204050116
X-Proofpoint-ORIG-GUID: jA2nI0Eav41L_NPPv7oUiqDeJD4w1-1O
X-Proofpoint-GUID: jA2nI0Eav41L_NPPv7oUiqDeJD4w1-1O
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFzb24sDQoNCkl04oCZcyBhIGhhcm1sZXNzIGVycm9yLCBidXQgd2UgYXJlIGxvb2tpbmcg
YXQgc3VwcHJlc3NpbmcgaXQuDQoNCkFsYW4NCg0KPiBPbiBBcHIgNSwgMjAyMiwgYXQgMTowMCBQ
TSwgSmFzb24gQS4gRG9uZW5mZWxkIDxKYXNvbkB6eDJjNC5jb20+IHdyb3RlOg0KPiANCj4gSGkg
QWxhbiwNCj4gDQo+IEkgdG9vIGFtIHNlZWluZyB0aGlzLiBUcmFja2luZyBpdCBkb3duIHRvIHRo
ZSBzYW1lIGNvbW1pdCwgSSBkZWNpZGVkIHRvDQo+IGVuYWJsZSBOVk1FX1ZFUkJPU0VfRVJST1JT
IHRvIGdldCBzb21lIG1vcmUgaW5mb3JtYXRpb24uIE5vdyBvbiBib290IGFuZA0KPiBldmVyeXRp
bWUgSSB3YWtlIHVwIGZyb20gc2xlZXAsIEkgc2VlOg0KPiANCj4gWyAgIDg5LjA5ODU3OF0gbnZt
ZSBudm1lMDogU2h1dGRvd24gdGltZW91dCBzZXQgdG8gOCBzZWNvbmRzDQo+IFsgICA4OS4wOTg2
ODNdIG52bWUwOiBJZGVudGlmeSgweDYpLCBJbnZhbGlkIEZpZWxkIGluIENvbW1hbmQgKHNjdCAw
eDAgLyBzYyAweDIpIE1PUkUNCj4gWyAgIDg5LjExOTM2M10gbnZtZSBudm1lMDogMTYvMC8wIGRl
ZmF1bHQvcmVhZC9wb2xsIHF1ZXVlcw0KPiANCj4gV2l0aCB0aGF0IG1pZGRsZSBsaW5lIGluIHJl
ZC4NCj4gDQo+IFF1ZXN0aW9uIGlzOiBpcyB0aGlzIGFjdHVhbGx5IGFuIGVycm9yPyBJZiBub3Qs
IG1heWJlIGl0IHNob3VsZG4ndCBiZQ0KPiBwcmludGVkIGFzIGEgS0VSTl9FUlIuIEFuZCBpZiBp
dCdzIHByaW50ZWQgYXMgYSBLRVJOX0lORk8sIG1heWJlIGl0DQo+IHNob3VsZCBvbmx5IGRvIHNv
IHdoZW4gQ09ORklHX05WTUVfVkVSQk9TRV9FUlJPUlM9eT8gT3IgZG8geW91IHRoaW5rDQo+IHRo
ZXJlIGlzIGFjdHVhbGx5IHNvbWUgb3RoZXIgZGlhZ25vc3RpYyB2YWx1ZSBpbiBoYXZpbmcgdGhp
cyBwcmludA0KPiBhbHdheXM/DQo+IA0KPiBVc2luZyBhIFNhbXN1bmcgU1NEIDk3MCBFVk8gUGx1
cyAyVEIsIGZpcm13YXJlIHZlcnNpb24gMkIyUUVYTTcsIGluIGNhc2UNCj4gdGhhdCdzIHVzZWZ1
bCBpbmZvLg0KPiANCj4gSSBhbHNvIG5vdGljZWQgYSB+MiBzZWNvbmQgYm9vdCBkZWxheSBvbiA1
LjE4LXJjMToNCj4gDQo+IFsgICAgMC45MTc2MzFdIHBzdG9yZTogVXNpbmcgY3Jhc2ggZHVtcCBj
b21wcmVzc2lvbjogZGVmbGF0ZQ0KPiBbICAgIDAuOTE3ODA3XSBLZXkgdHlwZSBlbmNyeXB0ZWQg
cmVnaXN0ZXJlZA0KPiBbICAgIDAuOTUxODQwXSBBQ1BJOiBiYXR0ZXJ5OiBTbG90IFtCQVQwXSAo
YmF0dGVyeSBwcmVzZW50KQ0KPiBbICAgIDMuMTQ2NzY1XSBudm1lIG52bWUwOiBTaHV0ZG93biB0
aW1lb3V0IHNldCB0byA4IHNlY29uZHMNCj4gWyAgICAzLjE0NjkxOF0gbnZtZTA6IElkZW50aWZ5
KDB4NiksIEludmFsaWQgRmllbGQgaW4gQ29tbWFuZCAoc2N0IDB4MCAvIHNjIDB4MikgTU9SRQ0K
PiBbICAgIDMuMTg4ODUyXSBudm1lIG52bWUwOiAxNi8wLzAgZGVmYXVsdC9yZWFkL3BvbGwgcXVl
dWVzDQo+IFsgICAgMy4xOTgxNjNdICBudm1lMG4xOiBwMSBwMg0KPiBbICAgIDMuMTk5NTU0XSBG
cmVlaW5nIHVudXNlZCBrZXJuZWwgaW1hZ2UgKGluaXRtZW0pIG1lbW9yeTogMTI5NTJLDQo+IA0K
PiBJIGhhdmVuJ3QgbG9va2VkIGludG8gaXQgbXVjaCwgYnV0IEkgYXNzdW1lIGl0J3MgYWxzbyBO
Vk1lIHJlbGF0ZWQ/IE9yDQo+IG1heWJlIHRoZSB2Y29uc29sZSBpcyBqdXN0IGluaXRpYWxpemlu
ZyBmYXN0ZXIgc28gSSBzZWUgdGV4dCB3aGVyZQ0KPiBiZWZvcmUgSSBkaWRuJ3QuIE5vdCBzdXJl
Lg0KPiANCj4gUmVnYXJkcywNCj4gSmFzb24NCg0K
