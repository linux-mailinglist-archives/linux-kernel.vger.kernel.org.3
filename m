Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7ACD577FC6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 12:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbiGRKfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 06:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbiGRKfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 06:35:40 -0400
X-Greylist: delayed 229 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Jul 2022 03:35:39 PDT
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22572F584;
        Mon, 18 Jul 2022 03:35:38 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26IAL2AF031081;
        Mon, 18 Jul 2022 10:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qti.qualcomm.com; h=from : to :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=A57ykHIjk9u4TtrG8hxoS5zRO0oi8kV8jHvNS7uzwa0=;
 b=DPCQBWEzU4KU4B4VnUPwZ0aBM9075rMG5XzD4u4aOygvdPwaftdvZ4KTNteFGG3k/o1T
 xGx8YP0whShPFFRxat5F5LzlmJqQPyJpDvzpvFfpODGWDDgWq9Z88mIqzj4nFoJtZjh4
 1S2ikcm0kKGq8eaEBA7HTjj1UMgP8aL4QwOgqg+SPtgNAKtGqfdwbFEDKtfO/40q+Eq/
 6/zwvSQyZKQURlWGDyXst/Uz6IDCkE8qlSrBE9oWrYpfFWBKD4laeeaKTnjO4I97VYxG
 vOrCbVW37LyV5ginpjLfPFC3RtFDIqWQsfbuXGHhQIWe34zPDVcnuA3Lx5857OkQx0YD rw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hbnugv2nt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 10:35:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKR6I+iZ0Jdw80AXrqM/6o7+BpG6KiAEYtnDDw1+RXJ8Gs9OnmugvajRru8if0O/H6TVuDM9mjUmYihNVHV7gR/qr7ulSoEjldZSjN5TAmGJWxKTdRicvn0Z9fzsbz/kxzhp9FRhb2uuTb4kyDSoA1JYarl2zxHekzhU554Vp9Rk1d4At6KA9J9zY3wfdah6Sx3ag1MLf0cEnolAMWDWUioqyZ4Nxhw6YmN3yZ6igXrMGEzjGKeuXqJFREX4UMl41zBquyBl9iZZeL7AUwEwWGBa5AKmry+iYLTcLpo8+RGWPW9xfFi7Ku9Qhv77dpPcETLMN53T5jXEIIOyXj6nrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A57ykHIjk9u4TtrG8hxoS5zRO0oi8kV8jHvNS7uzwa0=;
 b=B+ziDoL/K85houMP9q5awehb6kpAS9UkCB5U7mMflhrgmToVURjLiEao2WfRL1UQ4Or+X7sftLxdZNYwrXM5CuKffdIa8AfIzJEtvB+7FXDQLho1PMlqXkMPNExcC4c9GqeYFYyblfgytx3a+GFw6V6QpvX4WODmReX1K1aipnu4ggr+vA45ob5d46fri8/kLgpDZ7LNSCP4AY9/W1+68qlzDEaL24PhYUee+xepHAMklmHf1KEiJ2XafjRwppgTBjlTXJby/WiCgCXV5O0s4jlzjJpWv1QJ5wHUbbv9nV8qfEmDp88skPBVfRG6TZLscEfiPD1vwPPhO+UIILTYOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from SJ0PR02MB8848.namprd02.prod.outlook.com (2603:10b6:a03:3dc::5)
 by BL0PR02MB5490.namprd02.prod.outlook.com (2603:10b6:208:83::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Mon, 18 Jul
 2022 10:35:31 +0000
Received: from SJ0PR02MB8848.namprd02.prod.outlook.com
 ([fe80::4891:a5e3:92c:29ab]) by SJ0PR02MB8848.namprd02.prod.outlook.com
 ([fe80::4891:a5e3:92c:29ab%5]) with mapi id 15.20.5417.026; Mon, 18 Jul 2022
 10:35:31 +0000
From:   "Viswanath Boma (Temp)" <vboma@qti.qualcomm.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        "Viswanath Boma (Temp) (QUIC)" <quic_vboma@quicinc.com>,
        "stanimir.varbanov@linaro.org" <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Stanimir Varbanov (Consultant)" <c_svarba@quicinc.com>
Subject: RE: [PATCH 1/7] venus : Add default values for the control
 V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY
Thread-Topic: [PATCH 1/7] venus : Add default values for the control
 V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY
Thread-Index: AQHYlepOQnzhUypSuEKIITnLM9ogAq16vEgAgAk7DEA=
Date:   Mon, 18 Jul 2022 10:35:31 +0000
Message-ID: <SJ0PR02MB8848F24C0D8EB37C7C97A625858C9@SJ0PR02MB8848.namprd02.prod.outlook.com>
References: <20220712122347.6781-1-quic_vboma@quicinc.com>
 <b06c71d090ae7eaa3cd047bb0067f566371bac3a.camel@ndufresne.ca>
In-Reply-To: <b06c71d090ae7eaa3cd047bb0067f566371bac3a.camel@ndufresne.ca>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: c_svarba@quicinc.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af7feaaa-041e-48c3-5826-08da68a93d56
x-ms-traffictypediagnostic: BL0PR02MB5490:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: La+lG7jtadWg4NN8Ck6ympyMdRXZHUnA5yzW3H45Iw2UDu8UZgsY1L1PL6t+6eiTonbSRrVYp2lsQzOKIndWotWSvYnf4In5k9FwvnXAWuKc1KRCkSk2l8BwmL+KMIbF/jEzMIi1Mh4djOjrNLRM3y6GateOVBshRYnU/qJnOddduvX7wQ8rsUFWKjUfOPrOXR4i2+coo70xL0KapJIuKbuV1y280/zQ3Pv1REzdmTRaqTMO2mzcnYRjRWtoGrrRYW+LAtiwA7MGahMnXMEVmPMwFx7s+35GOjoWLBbr3LhGQYfBDCNrkG9YBMrJpgWoHRJc7No+R+Nz1airz23TnGr5e2qH9TGv/04+wiS0Lv0cekc4ER5A6zgvhVPOgyqwNGi2WVzjWbR3Pzh+moyxo6dpUanH1RlUah5nv9HFMPPMbVUCuHepUUKiUSjAkO4XGYcqOtTRekmaNBdTsBL2zO/Dzv+8SI/1knf0TUD/QEMEraKQsoh80CGLItjwQtBzaAwmeLwU1M+sgVvhPmTnxH6W7Ezp+eXu+um5ALMjENmV8b5eGK96l3TvBx8c9M78W66RNtLHX6KqSmULybIjb1L0l55HI5icwTdmh0RVliqIMdalw8ExaBtaPdAxfDK58K8WIOKQvo9stPRJyoQ+kPAt1WEv6RHak1VnaEd9CeuyJ0s+FX9uCE0SaIhrhBS7l5AKSqv1hBLIyH4cdMq5gkNBOpgBenjtsmF3mtBelHwDL1yWzMBR09At7wlsN1WqOMRibDXNeeCE8XSd/I4yLUfSD6mOoDU2fQHRWtUyg6HG2o9BE9YqA2I/9+FV7RG88QeToZFm69gOHiDICvOMHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8848.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(122000001)(316002)(41300700001)(110136005)(9686003)(7696005)(6506007)(26005)(2906002)(38070700005)(71200400001)(33656002)(66556008)(76116006)(5660300002)(38100700002)(52536014)(66446008)(921005)(64756008)(55016003)(66574015)(8676002)(66476007)(66946007)(83380400001)(8936002)(186003)(478600001)(53546011)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkF0MmhROGIyZjVyWEhYeGxFY1VXR0k5R0tRclAzK0l6dDAwTDYyNzdMZ3VG?=
 =?utf-8?B?UlpjWk8vdlYzYlVubGVzelBzeWR5cVZ3V2E3NXVFZ3F4eWdJaVozMVAxVkln?=
 =?utf-8?B?UndHOTJuNWUxU0hUMzI4eVIvZ3B0ejJhL2tNQ1ZXU2p3QU1GbVJZUW5JNXd2?=
 =?utf-8?B?c2wvcEltV1c2c0taUTJiZmI5Z1JTazBWYU9QUTAzZHNzQ1lReWJ1T0VMYWhD?=
 =?utf-8?B?K1JjSGdQbnFBMmNJSXd2Mk1nN1Z5dzJSRkZTZ0xmVmc2T0ZTaDVuRThOWUVE?=
 =?utf-8?B?WVhlSVJnQWlUVkdKSGxqVnBKS25JN3ZyeXpLdnUzVjZVQU5SV3R2VXRTRzhh?=
 =?utf-8?B?bXFRY3NZOXhFdWE0cGIvY090MHpBZWdTVHBHcWxrd0VOYXdqamxtelBySmVF?=
 =?utf-8?B?SStJK2Y4VHhiOTJIRjdhaW8zQlo4TjJjUEJnOWFPRXcvQU01NzlhdmVBT3Bh?=
 =?utf-8?B?d2lBNExUU3NLZmhaZFFwT0lSRG9yREQzbTVRRldyeGoxYVhhY0VBcTNJM1gv?=
 =?utf-8?B?UDRCNytWVmcyRXFia0txejdra1FhY1I2MXhicm9mdzlISG1vYjlSano1TmdS?=
 =?utf-8?B?eDZhKzlrUG4xQWxJaCtTM2Y2eEhFUm5Nbnp3VS81VFNvcEtxVGQxMTFuUEly?=
 =?utf-8?B?QjdpK3JhWkxqN0xmZDd5UTFNT1Z2Q2l6Z1NPK2JtVnM2a21CUDJsdXN3RXRP?=
 =?utf-8?B?S1JOYkJlZ0FVL0JlaVFNanJWVmdDaE01eHFCRjZiSEN0SVhiZHVWbmtEMDN2?=
 =?utf-8?B?N05DTmpCdmliVHZWOWhRRkIrRjEvL0w0NWpndzl4OVBKMVFsdGpsekZwMXdu?=
 =?utf-8?B?dWIrUFE3MnQrSVg3aTkrSm50UTJrem9EaThSUHZsNUo4T0pVNmhIRUdtbHg5?=
 =?utf-8?B?MXFLd3lRekxkRVhOaXFRUVl5Vm1wL1F6RGRZRmwyRjFkQXp4d3F6WWpITXhv?=
 =?utf-8?B?LzVvblc0aFFLQ3kvSFNhQXNZZG5WdFFGMnY5WHo5Smh0eDZUc3J3V3FvWkhm?=
 =?utf-8?B?ZTdsVzZmYU1aT200a1M4YzJLTGI3L1JicDduUDJ4MTRsM05rVmF3TlQ2d0Nv?=
 =?utf-8?B?TWVYRlRhR3pFK2VYZnVGUjE0ZGE5QStJcjhnTzFmeFR2SWR6NjlnQkRuOVJB?=
 =?utf-8?B?UXdyWkk1TkVlU3pNRHdvT0pxVC8xYjNQeHMrU0tJMmNDZncxM3VscXh3MGZD?=
 =?utf-8?B?RjJhZUZoN0hYRnAzaGtvTzUrUTRRVWJZMkx0TW5KOGRVNDNsUWJGV3gvZjg0?=
 =?utf-8?B?cGRiNis3b0RIMUpFM2xlWjBHbDRjeFZpYUhBT0lVOUdvR2sxM0E3Uys1RVhL?=
 =?utf-8?B?RlY5VTV5Zmpydm95d2dBT0IvblZRWFd5UWd2YmRVU0FkT3djNlQ4T1NPdE9v?=
 =?utf-8?B?S3c3YXRSNmY2T2dLSkN0cWwvREorZTR5L2lvbU1Pd2lYRzdtTGRnSUNHeDdy?=
 =?utf-8?B?cHVQdnF2WUhWbW1Hbmh4RWZyeDJKV21BNks5YXZhMTFyVGpZMnpDdEdTVWhp?=
 =?utf-8?B?TnkvWlhlTzduQzZmOSthdG92SjFqWWNaenFKWVhUd1d3Wk1WbHg3ZWU2Wlpn?=
 =?utf-8?B?RXZJd2QvMVpOa1ZVck1qbHZRS0syMGszVm9TeWFDb2tTODloeG5FQVF3WU5s?=
 =?utf-8?B?WG5YcS9PSmlzL2I0eFRwWW1IdzV5cEpvM1RDMTJqMkZ5VW93UDQrZnRweHkr?=
 =?utf-8?B?THdyd050SXpiU1RqY3NYT0U3SGhMY0J0K01OOGRIaGJWWlJiQ2ZoaU1CaHNa?=
 =?utf-8?B?NzU4YUg3aThQU2t0Qy85R0hIZ2hYamRSRExhYnpQQ1FnbFB3eEVmQ1FFUEd3?=
 =?utf-8?B?Wm1vUVR4RzlqbmJsR2xxYmtLUGhHNFRMYVEybEI1WDF3NzZsQkxIc3lyWVlL?=
 =?utf-8?B?OE43TUhhZXI4U2w3ak1DT3pjMGgrdG9BWUlFb0tMWEcyUkc3cS9nNEhDUG14?=
 =?utf-8?B?eXZkZmhyYUZFKzVJaDZ3Y0RVcHpUR0lSSmZYYVp3MzFVSmtVUTcwaFp5Q0lN?=
 =?utf-8?B?UndxQXlWbHVqeU04Z3didVRIbTF4c25KcFUvVGRwb1NMNHJkNEE0c01CSTlM?=
 =?utf-8?B?dDhyZlp6bW03Uk1JOU4vd0RHeTNPaUYveElDZXp5RlJxYXZuenVKUE9ZalRj?=
 =?utf-8?Q?gen7wl0pEAIEGi/nin+o0xLHs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8848.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af7feaaa-041e-48c3-5826-08da68a93d56
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 10:35:31.4020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zPisU3q06mpoPVdJQtoPLwDe4qnYh2/ErPAeUu7o33UaTu7E9Ifeky+xVg+/NqIalmBrp4+Zwc19suSLqeO7aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5490
X-Proofpoint-GUID: Axs3vnJZaFDHudtDKb87EJGwWPcL6a87
X-Proofpoint-ORIG-GUID: Axs3vnJZaFDHudtDKb87EJGwWPcL6a87
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_10,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1011 spamscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207180044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBOaWNvbGFzIER1ZnJlc25lIDxu
aWNvbGFzQG5kdWZyZXNuZS5jYT4gDQpTZW50OiBUdWVzZGF5LCBKdWx5IDEyLCAyMDIyIDc6MDQg
UE0NClRvOiBWaXN3YW5hdGggQm9tYSAoVGVtcCkgKFFVSUMpIDxxdWljX3Zib21hQHF1aWNpbmMu
Y29tPjsgdmlkZW8udXBzdHJlYW0uZXh0ZXJuYWwgPHZpZGVvLnVwc3RyZWFtLmV4dGVybmFsQHF0
aS5xdWFsY29tbS5jb20+OyBzdGFuaW1pci52YXJiYW5vdkBsaW5hcm8ub3JnOyBBbmR5IEdyb3Nz
IDxhZ3Jvc3NAa2VybmVsLm9yZz47IGJqb3JuLmFuZGVyc3NvbkBsaW5hcm8ub3JnOyBNYXVybyBD
YXJ2YWxobyBDaGVoYWIgPG1jaGVoYWJAa2VybmVsLm9yZz47IGxpbnV4LW1lZGlhQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtYXJtLW1zbUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggMS83XSB2ZW51cyA6IEFkZCBkZWZhdWx0
IHZhbHVlcyBmb3IgdGhlIGNvbnRyb2wgVjRMMl9DSURfQ09MT1JJTUVUUllfSERSMTBfTUFTVEVS
SU5HX0RJU1BMQVkNCg0KV0FSTklORzogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lk
ZSBvZiBRdWFsY29tbS4gUGxlYXNlIGJlIHdhcnkgb2YgYW55IGxpbmtzIG9yIGF0dGFjaG1lbnRz
LCBhbmQgZG8gbm90IGVuYWJsZSBtYWNyb3MuDQoNCkxlIG1hcmRpIDEyIGp1aWxsZXQgMjAyMiDD
oCAxNzo1MyArMDUzMCwgVmlzd2FuYXRoIEJvbWEgYSDDqWNyaXQgOg0KPiBGcm9tOiBTdGFuaW1p
ciBWYXJiYW5vdiA8c3RhbmltaXIudmFyYmFub3ZAbGluYXJvLm9yZz4NCj4NCj4gIFY0bDIgZW5j
b2RlciBjb21wbGlhbmNlIGV4cGVjdGluZyBkZWZhdWx0IHZhbHVlcyBvZiBjb2xvcm1ldHJ5IGZv
ciB0aGUgY29udHJvbC4NCg0Kbml0OiBjb2xvcm1ldHJ5IC0+IGNvbG9yaW1ldHJ5DQpbdmJvbWFd
DQpXaWxsIGVuc3VyZSB3aXRoIG5leHQgcGF0Y2ggc2V0IC4NCj4NCj4gQ2hhbmdlLUlkOiBJMWRi
MGQ0OTQwYjU0ZTAzM2Q2NDZjZTM5ZDYwZGM0ODhhZmJhOGQ1OA0KPiBTaWduZWQtb2ZmLWJ5OiBW
aXN3YW5hdGggQm9tYSA8cXVpY192Ym9tYUBxdWljaW5jLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L21lZGlhL3BsYXRmb3JtL3Fjb20vdmVudXMvdmVuY19jdHJscy5jIHwgNCArKystDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL3Fjb20vdmVudXMvdmVuY19jdHJscy5jIA0KPiBi
L2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vcWNvbS92ZW51cy92ZW5jX2N0cmxzLmMNCj4gaW5kZXgg
ZWE1ODA1ZTcxYzE0My4uMzdiYTdkOTdmOTliMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tZWRp
YS9wbGF0Zm9ybS9xY29tL3ZlbnVzL3ZlbmNfY3RybHMuYw0KPiArKysgYi9kcml2ZXJzL21lZGlh
L3BsYXRmb3JtL3Fjb20vdmVudXMvdmVuY19jdHJscy5jDQo+IEBAIC0zNTIsNiArMzUyLDggQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCB2NGwyX2N0cmxfb3BzIHZlbmNfY3RybF9vcHMgPSANCj4geyAg
aW50IHZlbmNfY3RybF9pbml0KHN0cnVjdCB2ZW51c19pbnN0ICppbnN0KSAgew0KPiAgICAgICBp
bnQgcmV0Ow0KPiArICAgICBzdHJ1Y3QgdjRsMl9jdHJsX2hkcjEwX21hc3RlcmluZ19kaXNwbGF5
IHBfaGRyMTBfbWFzdGVyaW5nID0geyB7MzQwMDAsIDEzMjUwLCA3NTAwIH0sDQo+ICsgICAgIHsg
MTYwMDAsIDM0NTAwLCAzMDAwIH0sIDE1NjM1LCAgMTY0NTAsIDEwMDAwMDAwLCA1MDAgfTsNCg0K
V2hhdCBpcyB0aGUgb3JpZ2luIG9mIHRoZXNlIHZhbHVlcyA/IFNob3VsZCB0aGlzIGJlIGRvbmUg
aW4gdGhlIGNvbnRyb2wgZnJhbWV3b3JrIGluc3RlYWQgPw0KW3Zib21hXQ0KQ29udHJvbCBmcmFt
ZSB3b3JrIGhhbmRsaW5nIHRoZSBtaW4vbWF4IHZhbHVlIHRoYXQgcmVxdWlyZWQgd2l0aCB0aGUg
ZGVmYXVsdCBjb250cm9sIG9iamVjdC4NCkFzIHBlciBAU3RhbmltaXIgVmFyYmFub3YgKENvbnN1
bHRhbnQpICBpbnB1dHMgLGFkZGVkIHRoZXNlIHZhbHVlcyBmb3IgdGhlIGRlZmF1bHQgLg0KSEkg
LCBAU3RhbmltaXIgVmFyYmFub3YgKENvbnN1bHRhbnQpICwgY291bGQgeW91IHBsZWFzZSBzaGFy
ZSBtb3JlIGluZm8gYXMgcmVxdWlyZWQgLg0KDQo+DQo+ICAgICAgIHJldCA9IHY0bDJfY3RybF9o
YW5kbGVyX2luaXQoJmluc3QtPmN0cmxfaGFuZGxlciwgNTgpOw0KPiAgICAgICBpZiAocmV0KQ0K
PiBAQCAtNTgwLDcgKzU4Miw3IEBAIGludCB2ZW5jX2N0cmxfaW5pdChzdHJ1Y3QgdmVudXNfaW5z
dCAqaW5zdCkNCj4NCj4gICAgICAgdjRsMl9jdHJsX25ld19zdGRfY29tcG91bmQoJmluc3QtPmN0
cmxfaGFuZGxlciwgJnZlbmNfY3RybF9vcHMsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFY0TDJfQ0lEX0NPTE9SSU1FVFJZX0hEUjEwX01BU1RFUklOR19ESVNQTEFZLA0KPiAt
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2NGwyX2N0cmxfcHRyX2NyZWF0ZShOVUxM
KSk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHY0bDJfY3RybF9wdHJfY3Jl
YXRlKCh2b2lkIA0KPiArICopJnBfaGRyMTBfbWFzdGVyaW5nKSk7DQo+DQo+ICAgICAgIHY0bDJf
Y3RybF9uZXdfc3RkKCZpbnN0LT5jdHJsX2hhbmRsZXIsICZ2ZW5jX2N0cmxfb3BzLA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICBWNEwyX0NJRF9NUEVHX1ZJREVPX0lOVFJBX1JFRlJFU0hfUEVS
SU9ELCAwLA0KDQo=
