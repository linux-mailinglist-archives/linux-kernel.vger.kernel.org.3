Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E0D578043
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 12:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbiGRKwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 06:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbiGRKwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 06:52:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACC120BE5;
        Mon, 18 Jul 2022 03:52:13 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26I9tEQM020588;
        Mon, 18 Jul 2022 10:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qti.qualcomm.com; h=from : to : cc
 : subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=oO8mCOi3GHxyqa+PwO+8maxCl4d533X3fwy4Hsn02Z0=;
 b=ggKBEMBDlsX16BqrdYVwCC5L1HO3g3DVsuD9XNXKXy82WSiv+qYNr/bFVlfVoey+8wUN
 zgGxpU4LwrrhoN0NiAqh+vxCUdHb/khhDqNZCez28xqt9/Iq/ZmDn9enWvdTTgv15vhM
 yQVpw9z3yrmN1Gqa3OsZ6MRlC1hRm8q67g7/WNMyo7YeMzWHvwxy68DyMoHqlDRJny5S
 D7+iUkYhHsmjiwfPHLIaeIo1UskcQjSUFgk/RvIeWo55se0+G4ILDwnAQxeC9hkqpB63
 uxLeVJhrB86so1w7948G3dO9jGnEDNmw/pFOvksaDGHayLaXExHQyxYfud+Y7Z/6ZgPI OQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hbnrv43u4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jul 2022 10:31:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6M5YsWRR4uqkfzYEpmdPHluhe6ApDbPak/yKUA46hVZn14LmMdSRCuEhCXt/sG755ZAj10Spu3TYEygO8UCycHAT7rHG9pYMAqV/lIJHlsTJI9l6Um93ic0+7wFFDxq2upbFsi5pYPwY0DdKbirSLsFHftDRsdTdTntenNetlh48dtP5oXpMEXR0x3qm9QWI57yBeq/FpWAoXdeb+A1fiEVyFt5Q9bk6GpzMjmz9y99/Qzp1jGgwJ1ngwcQ4TOPgwxXJDCb1cCztIDl7ub/np4+x9+FtnqBInlt62hlQDENbiFVMLpXJnOXHsF6FkQM3Npo7lDmTw9TIvByGvHbxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oO8mCOi3GHxyqa+PwO+8maxCl4d533X3fwy4Hsn02Z0=;
 b=i+6l3KLOVKqdccQRAuCK4fZS5695EnvhFMmw3fA0RDqpNFYlnoHriFmquO7whthfgAZnUdsCmGbJoOjShgvcE7w3HxJuyvaP2O4cWuf25Z/UXP0VGDRkCFgeEN5BRklz43ovTMNZIF89hqaB03R4eqKqYEkZ3apE1wMqBFKbw45ZhzWVB+qT677Wvn7YNVLEtHnHpRLOh9UXVxyssxiPu/0BGs5Ji9jHQDLEcVleS1XNJnTGBarmKgb8tjvTa6uSxY3AvxGLIjRKN8vLgy3u3HDJuJS2CFjD8SlVSYvFxXwg8HtPoyJQ2U4jZVHy1Q+/6EBh9lAImDwv5m9NRRLFlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from SJ0PR02MB8848.namprd02.prod.outlook.com (2603:10b6:a03:3dc::5)
 by DM6PR02MB4089.namprd02.prod.outlook.com (2603:10b6:5:9d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Mon, 18 Jul
 2022 10:31:36 +0000
Received: from SJ0PR02MB8848.namprd02.prod.outlook.com
 ([fe80::4891:a5e3:92c:29ab]) by SJ0PR02MB8848.namprd02.prod.outlook.com
 ([fe80::4891:a5e3:92c:29ab%5]) with mapi id 15.20.5417.026; Mon, 18 Jul 2022
 10:31:36 +0000
From:   "Viswanath Boma (Temp)" <vboma@qti.qualcomm.com>
To:     "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "Viswanath Boma (Temp) (QUIC)" <quic_vboma@quicinc.com>
CC:     "stanimir.varbanov@linaro.org" <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/7] venus : Add default values for the control
 V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY
Thread-Topic: [PATCH 1/7] venus : Add default values for the control
 V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY
Thread-Index: AQHYlepOQnzhUypSuEKIITnLM9ogAq16q+GAgAlK7DA=
Date:   Mon, 18 Jul 2022 10:31:36 +0000
Message-ID: <SJ0PR02MB88488C32CD93DB22C56FC008858C9@SJ0PR02MB8848.namprd02.prod.outlook.com>
References: <20220712122347.6781-1-quic_vboma@quicinc.com>
 <20220712123523.GB21746@workstation>
In-Reply-To: <20220712123523.GB21746@workstation>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1172eb8-e2a8-4b72-3118-08da68a8b125
x-ms-traffictypediagnostic: DM6PR02MB4089:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yYw+uyUEOlrS4jVNbfBE+FQLDqSbREp8bLbAEk+f6ZIvWgRHDh3B2Im4RSxQSMVq0s8gUReiqbZz6s+1b0+PfJXjgGNBWm1vGYQjys+jb1LC+8DD29gyA2iHINSeUpusUrNqCqmLfU6a2kjFtvDIc2fPKhFwvguzRMFbb0tUE/P7abS/4A/9Ula0zUQfQUqVXXZDE9OVQJROgeiWW1yXcewF8QrdfRTHGhegPEV4gcx2q3V5dQdXrnt+mcqALsapvl3T9SQSikmKSlhjf5/NcJOwpJGnRJGZL5XPvwZg7KzHrM759hcXRf1b0uKidsjUIse9ra1TKdLEU+D29IJN1+ym3MxBq2KvgCHzRCTItwOP8CCxTap/8fZQ3ydfReOh1KalHpvTY5S7Fz4aTmixX0UPoCCoOKolc8cZLaWNbT2IRPSO9NwL7q0+nLWOV2Q38l0oSewlWrGT9yNz6G8nScnICqVEiWT88z2rBI6ze3MmH7UIukIscHpwN7umh9K6ATKQSo0V8AKFknaQowWIrOOY2VJ75SSBaru76+b19QTod4dkksV2tgbbpwmIgVfN8u17tqQrmbtuQdOr8MSCiWfx5jK+T3RPG84J/rwrsIhyaf/6zgbMKky90+YV9m/oCvNveOTHkwnQr53cmspTAynqI0IeWuD+iwZVFvUEAvpTLSy7qeP+ItwhPcxoQUyfVIfnZclMlZdXIetaVwwRVXjU55r3OPGHTfvyV5YaCDWskgsNFWAaD2SPBsORb6x218ImtWFnR6REW6fusLfd2lMv7WAD4JVovsC33hPe8w7+HKgRYYEcJ2lbg9pETEg0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8848.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(122000001)(55016003)(316002)(83380400001)(38070700005)(186003)(38100700002)(66946007)(52536014)(33656002)(5660300002)(76116006)(71200400001)(4326008)(66556008)(66476007)(2906002)(41300700001)(478600001)(66446008)(64756008)(8676002)(26005)(9686003)(7696005)(6506007)(8936002)(53546011)(86362001)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wlGr1xhTwcfRagbwGHchZjgrkQELzOWOqbcWaZa641IdDy9BlTN1rV9/nZII?=
 =?us-ascii?Q?Uz2ycT1xjbHLqZtN9iESb6+O4Efh6xLlNjV/5DiieJun/LN2YkQPsJxMJLBC?=
 =?us-ascii?Q?zD+0d/nYrr6+qaKsTWtNjkd5jYCcBxwUDE2gweAAHAxI5RJuJtKy8IZxRuba?=
 =?us-ascii?Q?RvImqzJK+MgfPbTFPkOv7iotCL1rv0xOYy5Rq9GGrQyUxePs/t6bk2Gy9w10?=
 =?us-ascii?Q?90aJHK/XGMWlSwJ1gDqoNcyiSmHq/OpNGq2rQ6YdF2kJd2ljKaxyNC/Arlbb?=
 =?us-ascii?Q?oeR0Batt71+kt211Fh1IzUH1JQiVzhqN7k+Ek/gxnRxvDLERgdSYE6Mj2+Mn?=
 =?us-ascii?Q?tA6GCxaESEf6rUV485fDSXCSX6yiqjzO3QM9VmZGfJr/ZcGZxul+0lfjmE5J?=
 =?us-ascii?Q?GGWsIF0EYJr9aVeFX8xStceBZczJRPid9vfATCPyikSBk5zg0vNPWa04bLEc?=
 =?us-ascii?Q?Idt2UBaOyUFCUUCj1uBKzNW9sv+STeLj9qDRtSrv5qUim/mY0vY0ithGxea0?=
 =?us-ascii?Q?9GVRfMiLeqb0oIGbqcZL3ga3ECkV+YSlHBwyIG4JjeO5bJ+1jRcOYKbUAD0v?=
 =?us-ascii?Q?DwVuUMqrE5g3qHMfhuMys5xXe5VG6q4pswSKsxHkvqNfYr8eZhR7o5+hbMXs?=
 =?us-ascii?Q?KhIhTs2NBusL/SmU0jD8wkH/1r5UjvQljT6VX+mFEhS6xPNu1X9wCYFNU1PG?=
 =?us-ascii?Q?PZNI6pl83yO1CgFiIxbPnNRqXntb/JI5WqOksUM6gVzeMDkeqJXSi9vaPqsu?=
 =?us-ascii?Q?wW7Dh8Q3ZxyXPBNcvSbtCYw3svmt0b/7dvymqDCJzieEix2Sf1AeHF1sMP7R?=
 =?us-ascii?Q?rgtouaWWOjHBGnSpHhkiumwtx+8fDoSVCU5PoWTaQ/JTXun3YNjDPjIPW36O?=
 =?us-ascii?Q?1qQpGaLaelTjZDMcvec7Gnhs+icU57lF+P41aVjJsy6vXXGjpxy4Y9z7JueU?=
 =?us-ascii?Q?Ld7fWo1qSAbakswtRGCFCeL7PRuT/8Tia1dYRNNg+iSyc5Bl5ykMg4J5o15y?=
 =?us-ascii?Q?QBVDoLCoRTzPpT0i27DvVI5r5r629N5q1OB0t+0HGHE095ugviWs88eXs4UY?=
 =?us-ascii?Q?yl4X0gRkY3NYv/sf9cSWRevCGpbKB5J/MA8Yw+tGKUYtyls6/YaZlE3uzKnf?=
 =?us-ascii?Q?t3Wm4mdCMy3Zr2fircaHmsvSFFUT2Ade9UH7NPCoOeOKPR8envJc7cFpJy2d?=
 =?us-ascii?Q?c5QgwMYKPhSA+mIPqzRnfCVQfXSxi0VjSyMubf8F4OilwZK3M+Lv1MBY+x9W?=
 =?us-ascii?Q?r47TST/zSAS3f93+UAQKWI/mrilGxet4GKCXHb85gRmGvvx9B539bxus1OCy?=
 =?us-ascii?Q?AES+862tNduaUfmtZeb/60y4CcKkevCxK4xDiSLqHti6Qzz0KHZ7n+my1ZTI?=
 =?us-ascii?Q?Y+r7WWvkejiwyNlZpL9CtOsBNNdEje98qUABfnlNRuywGAC3u/f/2/WCWEo4?=
 =?us-ascii?Q?Xj431VVIEzBOXAwAag56FRkz2WxdZkcOCh6b3ehvQuDvRkoVE6xPw9Uj2Lf8?=
 =?us-ascii?Q?nHZBJYYKFMEWyo8Ile86pByFbjEUdNbsiANhjnHwkv7E0lQttpJ/ujy4kwHB?=
 =?us-ascii?Q?tAoeWkkTFju8bgoJjwqongW2SkaHlbFQu7Ql47ZB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8848.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1172eb8-e2a8-4b72-3118-08da68a8b125
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 10:31:36.1678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1X0s3qm9YtUePAM+4tQKflod9vmsnDZJPKr9xkJPTBEVfL1ROl1PKJuOPhd981hDsFjvqzCcOGe1Wuk5vqNa8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4089
X-Proofpoint-ORIG-GUID: 9cY9bndN5Iasnf5mz6N8O2zgDPHKL9S9
X-Proofpoint-GUID: 9cY9bndN5Iasnf5mz6N8O2zgDPHKL9S9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-18_10,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207180044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>=20
Sent: Tuesday, July 12, 2022 6:05 PM
To: Viswanath Boma (Temp) (QUIC) <quic_vboma@quicinc.com>
Cc: video.upstream.external <video.upstream.external@qti.qualcomm.com>; sta=
nimir.varbanov@linaro.org; Andy Gross <agross@kernel.org>; bjorn.andersson@=
linaro.org; Mauro Carvalho Chehab <mchehab@kernel.org>; linux-media@vger.ke=
rnel.org; linux-arm-msm@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] venus : Add default values for the control V4L2_CI=
D_COLORIMETRY_HDR10_MASTERING_DISPLAY

WARNING: This email originated from outside of Qualcomm. Please be wary of =
any links or attachments, and do not enable macros.

On Tue, Jul 12, 2022 at 05:53:41PM +0530, Viswanath Boma wrote:
> From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>
>  V4l2 encoder compliance expecting default values of colormetry for the c=
ontrol.
>
> Change-Id: I1db0d4940b54e033d646ce39d60dc488afba8d58

What does this represent here? I'm pretty sure it is meaningless to the ups=
tream kernel, so please get rid of it.
[vboma]
Will ensure with next patch set

> Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>

Since Stan is the original author of this and following patches, there shou=
ld be a s-o-b tag from him. After that you should add yours indicating that=
 you are carrying the patches from Stan.

Also, please add a cover letter stating the purpose of this series, how it =
is tested, and with any other relevant information.

Thanks,
Mani
[vboma]
Will ensure with next patch set
> ---
>  drivers/media/platform/qcom/venus/venc_ctrls.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c=20
> b/drivers/media/platform/qcom/venus/venc_ctrls.c
> index ea5805e71c143..37ba7d97f99b2 100644
> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
> @@ -352,6 +352,8 @@ static const struct v4l2_ctrl_ops venc_ctrl_ops =3D=20
> {  int venc_ctrl_init(struct venus_inst *inst)  {
>       int ret;
> +     struct v4l2_ctrl_hdr10_mastering_display p_hdr10_mastering =3D { {3=
4000, 13250, 7500 },
> +     { 16000, 34500, 3000 }, 15635,  16450, 10000000, 500 };
>
>       ret =3D v4l2_ctrl_handler_init(&inst->ctrl_handler, 58);
>       if (ret)
> @@ -580,7 +582,7 @@ int venc_ctrl_init(struct venus_inst *inst)
>
>       v4l2_ctrl_new_std_compound(&inst->ctrl_handler, &venc_ctrl_ops,
>                                  V4L2_CID_COLORIMETRY_HDR10_MASTERING_DIS=
PLAY,
> -                                v4l2_ctrl_ptr_create(NULL));
> +                                v4l2_ctrl_ptr_create((void=20
> + *)&p_hdr10_mastering));
>
>       v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
>                         V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD, 0,
> --
> 2.17.1
>
