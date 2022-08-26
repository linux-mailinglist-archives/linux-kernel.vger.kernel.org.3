Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C345A20ED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 08:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245026AbiHZGeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 02:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236536AbiHZGeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 02:34:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D28D11D8;
        Thu, 25 Aug 2022 23:34:12 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27Q6Isma019605;
        Fri, 26 Aug 2022 06:34:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=1uNg39J/f+bByv8dU9gnKovywZcP4G2RNcrQyUyLrr0=;
 b=aCRLdLhGz97QYukfyi4f3b10GHiShSfUFTBt96HcIIT6UVmW3GR0wKl5L67Mdklsjyau
 gS4eHsnFoarAXcYabfWNsMNnxCwu7lU5VCtLe4fyNbs0LesqTylBMGz0KXVRDGxLCy56
 TaqvRRZhIgMXxPamTJBXn7z3t3qPCxJbI41tIVh29yWabk322Z0HPUSuDZulM5M3N7Ep
 0No0VQuQCocPmYXA3THwYdbSYpNsd0tv22stuTySAWxZbowDM3Gtm2GZJG/V15cwRISN
 cFEqZHZ4r4UWqLxYqWqVyEhE9LXUt1d+q8u/1OVeIgBtpQhNB8y/BuFJcnQWplogTy+F VA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j5yten2h2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 06:34:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JilqKGGjcGLzT6I9PAQJzWHqvtbMd2Y9LVP3LBeoAbQUhuw5OF1+cAp8wfODgs0Vvn+avcslhd0AIu7WqgxK0hBon3mhq8df8/kMUXvm0LV7+sIQ2qfYB8eqPwqJ5/GC90vi6gjwP35tJqgh7x5gMWMyuVuJBJZwOhTotENdm8gwKQdlf2mNOoBYz6RavISQxo8S45d5giPwfpuPnHIXR+xextUp6MP11mn+KK2KCM7Bzy08TXnpGDYtjzpYHCXsTvYqw+EsePMaM9rVw92ctcUx/jd4Teyc7BuJzJ4myV9G4kyfFzk/fq9Pp3ZZKX4QzxdSKco/GHv80bhZ2x5D4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1uNg39J/f+bByv8dU9gnKovywZcP4G2RNcrQyUyLrr0=;
 b=FekCt4gAvOaGQ8Cstfiqr1bAzO00RKVfXW6y1IXy5n/PHQoLlRnGdzKkiFaiL2lvpusO2P4CU0BH+5Atismpw9pwKXu/xZQ4aOrO9vkeASnYskUrCynuQjOe31A5rgPwxnR9hSgWRed1agQvf90EdpEVSbQXcG1Q1kgcYc5VqaBQdRaYReBiZTr3ukk/yp3+Z+g6D5v/YIth/f8sasy6+df0RQqxHOCWRhcXO0IEmCo3Y2n0Jbrd/7qcP25E9vyy9Fu62jcdximEZx9cqfQ0z8FqnZXojWmYuHKEYHg1hDTkN3fl4QCFzgoPj6rfB3Xx2ohnDoGZJc1vBHQtqu8Nyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DM6PR02MB5148.namprd02.prod.outlook.com (2603:10b6:5:48::21) by
 PH0PR02MB7623.namprd02.prod.outlook.com (2603:10b6:510:5d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15; Fri, 26 Aug 2022 06:34:06 +0000
Received: from DM6PR02MB5148.namprd02.prod.outlook.com
 ([fe80::1956:4d5d:a7df:f85]) by DM6PR02MB5148.namprd02.prod.outlook.com
 ([fe80::1956:4d5d:a7df:f85%5]) with mapi id 15.20.5546.022; Fri, 26 Aug 2022
 06:34:06 +0000
From:   "Dikshita Agarwal (QUIC)" <quic_dikshita@quicinc.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Dikshita Agarwal (QUIC)" <quic_dikshita@quicinc.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>
CC:     "stanimir.varbanov@linaro.org" <stanimir.varbanov@linaro.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "Vikash Garodia (QUIC)" <quic_vgarodia@quicinc.com>,
        "Maheshwar Ajja (QUIC)" <quic_majja@quicinc.com>,
        quic_jdas <quic_jdas@quicinc.com>
Subject: RE: [PATCH] media: v4l2-ctrl: Add main 10 still picture profile for
 hevc
Thread-Topic: [PATCH] media: v4l2-ctrl: Add main 10 still picture profile for
 hevc
Thread-Index: AQHYtsGovo10cv4Nsky88Qqlv88qWa299leAgALH0JA=
Date:   Fri, 26 Aug 2022 06:34:06 +0000
Message-ID: <DM6PR02MB514811A30653D54C9010F25AF3759@DM6PR02MB5148.namprd02.prod.outlook.com>
References: <1661239563-14346-1-git-send-email-quic_dikshita@quicinc.com>
 <7122b146-46c7-7e58-5b26-4b94d3a8c1d8@xs4all.nl>
In-Reply-To: <7122b146-46c7-7e58-5b26-4b94d3a8c1d8@xs4all.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4284cc8-9e9a-4347-b390-08da872cf988
x-ms-traffictypediagnostic: PH0PR02MB7623:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SDpBbcYIcyznnzERO8vitej8gS7mLl4hCluw4TPWRR2/HTqb/xIVjD8n1gewsowDdCo2oUndBsg36igey4mD2tOyhcRs+Hz5oayQsQb59Qw/HzgAmnSB8/ugWRNYR1GHwiKPRx38PTc/0y9Oy8iqz/KGru98F4RjtIJMzKMaAsCaQxaNoWiFM4TPu46M7h5YF6baV/YeC29xdcnUss+Y8n5poqGm+yI/U+7SavIB7GiVWs0Z9zO3Xub5bNQygVx1c539eVJpAxyX8FqBT3VCRu+Q+NSklJdX7tk5VodrdeYluQnkycD5DaFSG5wjn1WrwULgt+iHeRDrTkIFuSrKvoWlwR0b3fgP2Ulo+clYbHYwTti6YSC2j+E7Y3Y1VHTwrdWsWQkHSRy00yusoZvVeifv0j5zBDm4Vayh9Lmdhu2sbKnoPWkKiPqOnrm9KqiwRX3/34V40nRAtwBTTHcEppVM5vvKUQxZ6RDQuCC1TmpTVQkRJa7ObQakgiR5dX5wcT8I6qYj64P+9hNT4KHOFUtxdobcwS/qo96cdvLHw/T3XJwNEPcmIk9hTL/qvTi5KvtRSIT7atwgK8vDwEMeIh0IcKOrWoxYCcSyAQC18PchUj4PYHxwrINYAppx50KX0zZymeGN4o3fnWhTDVlYt12FLRRpZJsyH3qQUV87o75AzPCpIZQSQHn5oLZSwJlhmsbw2JGkrzl5bjqnPV8dSAW9Yw0NDVJsH0LBmdGolYXAYLStHRvfdDEQhQle92/ywgoG2kVdbqf15cJPFzYFtH+3nUB64Vd05S5A5yhQhRg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5148.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(107886003)(966005)(2906002)(41300700001)(53546011)(7696005)(6506007)(33656002)(66556008)(86362001)(8936002)(52536014)(66446008)(64756008)(66476007)(8676002)(76116006)(66946007)(4326008)(478600001)(5660300002)(55016003)(186003)(83380400001)(26005)(9686003)(38070700005)(110136005)(122000001)(316002)(38100700002)(71200400001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vi9nWkNDV3plR1EvRmFYNzhRSUJaSFdNdHdUUzQwUFFOcCs1NmZEQkd3Rzlj?=
 =?utf-8?B?YTU5dXRVWUMzR09Ia3ViUFgrRHErYUtGYVB4cUJXRmVUM2VWQlVRNFZVenRH?=
 =?utf-8?B?NFF1amYwaWZLSEFCQXVlcng2ZXdqWkJDN01idnpUQldqWWR0UVZuK0E5NmU1?=
 =?utf-8?B?SjRhSWN4aGo4QTExWEdsS00vUGlnZkdqNklKRUFFWnpoNS8vejdwNmhxRU1r?=
 =?utf-8?B?WEFPWXlnWjhYb25Rd3V3UGYvYjhGVlRxTnhPOW45b2txYVNiRUdlaFVtVHVV?=
 =?utf-8?B?SXE1NmZkMG9VQ1F2M1dGak1lSG1jYzhZenlxd0hKekt4WG9qdC9QNm9MTDBX?=
 =?utf-8?B?dkl6elBOeXhXY0NrbTBxVDVURnB5ZzcxbS85VHc2c2NVVk9yeXBFQWo3ZHB2?=
 =?utf-8?B?NUxOWTl1ZFZOWEVrSm5EVStYeTRQdFErbFBXT21vZFBaWDhTV3NJRG5oN2pk?=
 =?utf-8?B?ZStpRTQrMkRGcU90Vnp2UktlRFVYUnZJczJNc04zcHF4OVJjdjNYSjhGUG1W?=
 =?utf-8?B?NEQ5RU1WMDlmb3Q3QW9xZjZiUXlrbnBsdVEvcmtrb3VHeHpxalROamlUMkl3?=
 =?utf-8?B?VmhnMVJBckRaNzJKaVIyL21JRzRwTDI1VUx4cVRJdkxtVjJZOEpJNHlvdnRS?=
 =?utf-8?B?TE1CZ2puaHpUZ0VrVlZKWktBeEtrWUdrV3hxY3dDUFppMVY3c25xRmlscUFV?=
 =?utf-8?B?K08wamhRbi9aQWtjNkRYNWlrWGxVNmJ3SnZBRDUzZElrR1U0VWpUbHluZkQ5?=
 =?utf-8?B?ZTVYOVpsVnBsZE1INHIva3BLNmpZNzRPMHBwbUVSUUVENlRDQzdTMzkwcEc0?=
 =?utf-8?B?OVBkK25qSDB5Wk52OTJ0WWNUUTF2TjRMd0xrc25tQStLMVZOQ2RJNkg1UWhC?=
 =?utf-8?B?S0pTN1czT2NRc0VGZzNJZ1RhdVg1MUFhTlBwZlBGckV4YUV5RmdvbmZBY2hQ?=
 =?utf-8?B?Y3JyYWphREpWdW45ZGdObW1CWG5kRDhPbSt2L0lxanVOdWlKTzR6aU80SXJL?=
 =?utf-8?B?K21iUEpDSnZSK2hSUTgzc0dWdWJ0Kzc2bG8vVFB5QVFCYmU0d0FoaDBPV0xG?=
 =?utf-8?B?RDlRSGhFbTFHMXljU2JaSGhkRC9tZTJTcVdNemhRRGxNcGZwMHRxV0RzZ05y?=
 =?utf-8?B?Y2lrQjdTQ1NJbXZwRjc5R3l1d1FrSVY5NEI1NDJ3YnV3c3orWk4wdlc5Y0Vt?=
 =?utf-8?B?ZEpQblpaYmlQTmgrSzhyazNSVXlRNHJCK2xWQ2hoSkt0aXVaVHg3RU5vY3dY?=
 =?utf-8?B?dUNjT1RTVXJ6NE5JNWNwYndYK0xrYUlxVzM3Wjdwd3c2cXBlUmlhbkZkTlBY?=
 =?utf-8?B?emVWK0tZRTg1RGV5Rnl0S1FCek5ZNGw4d0p4bmRKQU95ME9RZWJDNzduN2tT?=
 =?utf-8?B?WXVTUVNmZXRRcFJ3YWthSktkZ3duSnlRVDJjTHJTZDM3bFI4cmIwRjg5dWFl?=
 =?utf-8?B?Q1U4d2xmc0VSSmsxUjIvZG1sYW9vTnhIT2pwdWIrczRtakpXM0VhcVQ3ZFc2?=
 =?utf-8?B?Q1hCdDBlMGFPQUs2a1N0WHg4OWFqcmpVL2NyeDFoU3pWRi9CMFIyMi9hZEJ0?=
 =?utf-8?B?ZnFiTDh1TnQrZ1E5ejZVbThobGhNMWFDZkc2eHliL0piN2huM1hnZFpQY0x5?=
 =?utf-8?B?OFVFaEVpamNTTUg5ckJCcmNjZWZ6WFc4eVpCVGxxNWZybDVDSjJrdUtrQVZG?=
 =?utf-8?B?ZkFjWExINlVaaEpId3ZvbFR0SjZaT29wLzk0V0loWnF5MDRKSEpGaERpcjJl?=
 =?utf-8?B?Z3NESTlvVnlvb2tjOHR6QzY3OENxbTBSWG0vMyt1OVVpTm15RkYyMk5DbWZw?=
 =?utf-8?B?S3Yrcm5iakl2a3Uwb2IvUzlGK29DeE5VdGVZbTluWUQ2Z2pBZnIxSzIxOUE2?=
 =?utf-8?B?WmZQYjZtV1ZmNC80Z2Y4blJTZ0VFV3dvQzBTdWhJT0oyVXF0cHBFRTZ2M2dn?=
 =?utf-8?B?djZWVzQrYnkzNkg0aENINWxTcXZFMThzS2t4ay9HTXk2alVZRDhEMjBkdEZo?=
 =?utf-8?B?NUJOT1paNE14TTBaU2xlMkc5WkpIUHlWWHZYditwZ1Z5c2FsK3Z6SGs0ajJR?=
 =?utf-8?B?VDRMWGVXTWNNZHZaZy9vcUExRkorUDBDcTdRTC82M3JUNDBJdDZCaFdlbnp2?=
 =?utf-8?Q?GGI0YEId4BzzVSCI0nxD2UJ8k?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4284cc8-9e9a-4347-b390-08da872cf988
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 06:34:06.0986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iXaYBr2jMbrSkFYSUG/USwT3vYI3vnHao7SDznbIlWUhgl6mOsCElf7lvCqKa23ef8Y0i3pHooDthxzfERBssP31oFc+yu3C7MicEyu6Umw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7623
X-Proofpoint-ORIG-GUID: Ck9uCxvwzQBrVfC2U3ErtPbAg5WjBV_8
X-Proofpoint-GUID: Ck9uCxvwzQBrVfC2U3ErtPbAg5WjBV_8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_02,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208260023
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSGFucywNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEhhbnMgVmVya3Vp
bCA8aHZlcmt1aWwtY2lzY29AeHM0YWxsLm5sPiANClNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDI0
LCAyMDIyIDU6MzYgUE0NClRvOiBEaWtzaGl0YSBBZ2Fyd2FsIChRVUlDKSA8cXVpY19kaWtzaGl0
YUBxdWljaW5jLmNvbT47IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgZXplcXVpZWxAY29sbGFib3JhLmNvbQ0KQ2M6IHN0YW5pbWlyLnZh
cmJhbm92QGxpbmFyby5vcmc7IGxpbnV4LWFybS1tc21Admdlci5rZXJuZWwub3JnOyBWaWthc2gg
R2Fyb2RpYSAoUVVJQykgPHF1aWNfdmdhcm9kaWFAcXVpY2luYy5jb20+OyBNYWhlc2h3YXIgQWpq
YSAoUVVJQykgPHF1aWNfbWFqamFAcXVpY2luYy5jb20+OyBxdWljX2pkYXMgPHF1aWNfamRhc0Bx
dWljaW5jLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIG1lZGlhOiB2NGwyLWN0cmw6IEFkZCBt
YWluIDEwIHN0aWxsIHBpY3R1cmUgcHJvZmlsZSBmb3IgaGV2Yw0KDQpIaSBEaWtzaGl0YSwNCg0K
T24gMjMvMDgvMjAyMiAwOToyNiwgRGlrc2hpdGEgQWdhcndhbCB3cm90ZToNCj4gQWRkIG1haW4g
MTAgc3RpbGwgcGljdHVyZSBwcm9maWxlIGZvciBIRVZDIGVuY29kZXIuDQoNCkhtbSwgaXMgdGhp
cyB0aGUgc2FtZSBhcyB0aGUgIk1haW4gNDo0OjQgU3RpbGwgUGljdHVyZSIgcHJvZmlsZSBtZW50
aW9uZWQgaGVyZToNCg0KaHR0cHM6Ly9lbi53aWtpcGVkaWEub3JnL3dpa2kvSGlnaF9FZmZpY2ll
bmN5X1ZpZGVvX0NvZGluZyNWZXJzaW9uXzJfcHJvZmlsZXMNCg0KSWYgbm90LCB3aGVyZSBpdCBp
cyBkZWZpbmVkPyBJIHdvdWxkIGFsc28gcHJlZmVyIHRvIGhhdmUgdGhpcyBwYXRjaCBtZXJnZWQg
dG9nZXRoZXIgd2l0aCBhIGRyaXZlciB0aGF0IHVzZXMgaXQuDQoNCkl0IGlzIGRpZmZlcmVudCBh
bmQgZGVmaW5pdGlvbiBjYW4gYmUgZm91bmQgaW4gTGF0ZXN0IEhFVkMgc3BlYywgQW5uZXggQSwg
QS4zLjMgTWFpbiAxMCBhbmQgTWFpbiAxMCBTdGlsbCBQaWN0dXJlIHByb2ZpbGVzLg0KaHR0cHM6
Ly93d3cuaXR1LmludC9yZWMvZG9sb2dpbl9wdWIuYXNwP2xhbmc9cyZpZD1ULVJFQy1ILjI2NS0y
MDE5MDYtUyEhUERGLUUmdHlwZT1pdGVtcw0KDQpUaGFua3MsDQpEaWtzaGl0YQ0KDQpSZWdhcmRz
LA0KDQoJSGFucw0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEaWtzaGl0YSBBZ2Fyd2FsIDxxdWlj
X2Rpa3NoaXRhQHF1aWNpbmMuY29tPg0KPiAtLS0NCj4gIERvY3VtZW50YXRpb24vdXNlcnNwYWNl
LWFwaS9tZWRpYS92NGwvZXh0LWN0cmxzLWNvZGVjLnJzdCB8IDIgKysNCj4gIGluY2x1ZGUvdWFw
aS9saW51eC92NGwyLWNvbnRyb2xzLmggICAgICAgICAgICAgICAgICAgICAgICB8IDEgKw0KPiAg
MiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL3VzZXJzcGFjZS1hcGkvbWVkaWEvdjRsL2V4dC1jdHJscy1jb2RlYy5yc3QgDQo+
IGIvRG9jdW1lbnRhdGlvbi91c2Vyc3BhY2UtYXBpL21lZGlhL3Y0bC9leHQtY3RybHMtY29kZWMu
cnN0DQo+IGluZGV4IDJhMTY1YWUuLjViMmRhODQgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRp
b24vdXNlcnNwYWNlLWFwaS9tZWRpYS92NGwvZXh0LWN0cmxzLWNvZGVjLnJzdA0KPiArKysgYi9E
b2N1bWVudGF0aW9uL3VzZXJzcGFjZS1hcGkvbWVkaWEvdjRsL2V4dC1jdHJscy1jb2RlYy5yc3QN
Cj4gQEAgLTI0MjQsNiArMjQyNCw4IEBAIGVudW0gdjRsMl9tcGVnX3ZpZGVvX2hldmNfcHJvZmls
ZSAtDQo+ICAgICAgICAtIE1haW4gc3RpbGwgcGljdHVyZSBwcm9maWxlLg0KPiAgICAgICogLSBg
YFY0TDJfTVBFR19WSURFT19IRVZDX1BST0ZJTEVfTUFJTl8xMGBgDQo+ICAgICAgICAtIE1haW4g
MTAgcHJvZmlsZS4NCj4gKyAgICAqIC0gYGBWNEwyX01QRUdfVklERU9fSEVWQ19QUk9GSUxFX01B
SU5fMTBfU1RJTExfUElDVFVSRWBgDQo+ICsgICAgICAtIE1haW4gMTAgc3RpbGwgcGljdHVyZSBw
cm9maWxlLg0KPiAgDQo+ICAuLiByYXc6OiBsYXRleA0KPiAgDQo+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL3VhcGkvbGludXgvdjRsMi1jb250cm9scy5oIA0KPiBiL2luY2x1ZGUvdWFwaS9saW51eC92
NGwyLWNvbnRyb2xzLmgNCj4gaW5kZXggNWY0NmJmNC4uMTE1OTMzNyAxMDA2NDQNCj4gLS0tIGEv
aW5jbHVkZS91YXBpL2xpbnV4L3Y0bDItY29udHJvbHMuaA0KPiArKysgYi9pbmNsdWRlL3VhcGkv
bGludXgvdjRsMi1jb250cm9scy5oDQo+IEBAIC03NDMsNiArNzQzLDcgQEAgZW51bSB2NGwyX21w
ZWdfdmlkZW9faGV2Y19wcm9maWxlIHsNCj4gIAlWNEwyX01QRUdfVklERU9fSEVWQ19QUk9GSUxF
X01BSU4gPSAwLA0KPiAgCVY0TDJfTVBFR19WSURFT19IRVZDX1BST0ZJTEVfTUFJTl9TVElMTF9Q
SUNUVVJFID0gMSwNCj4gIAlWNEwyX01QRUdfVklERU9fSEVWQ19QUk9GSUxFX01BSU5fMTAgPSAy
LA0KPiArCVY0TDJfTVBFR19WSURFT19IRVZDX1BST0ZJTEVfTUFJTl8xMF9TVElMTF9QSUNUVVJF
ID0gMywNCj4gIH07DQo+ICAjZGVmaW5lIFY0TDJfQ0lEX01QRUdfVklERU9fSEVWQ19MRVZFTAkJ
KFY0TDJfQ0lEX0NPREVDX0JBU0UgKyA2MTYpDQo+ICBlbnVtIHY0bDJfbXBlZ192aWRlb19oZXZj
X2xldmVsIHsNCg==
