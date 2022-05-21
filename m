Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A9952FED8
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 20:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344740AbiEUSvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 14:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiEUSvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 14:51:49 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7C65C341;
        Sat, 21 May 2022 11:51:48 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24L5sKQd012955;
        Sat, 21 May 2022 18:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=f/nb2sdJ017GBg8l5Oko9eF9krsbKwx/8bmgKqM+NbA=;
 b=o6j3u+TPhm9h1ha59HwSMvD+iXqn9smZtAkvHed/rttvl+47DdfBFFplevra3VcpTw7/
 B1argWc7jegRgzgeSMaZ/H+GYvFDZTYXFtgloRM23MsmOp6pAduL1uBOHm241iGXevNw
 M22RJVv7cFN9hEtGLBz49dpAeik5Z6CiGK9TDb/SQk7p8bEJViXZCf5/y+k+X2qxfWtT
 C0jG+DubfVygEFCedb0MfUztSjtaQh2t05UawnRTYOdpo/CEaO8nXOpzvssZEeRNvkmY
 8hnHiwkr21dg9YpdpSEnC32sKJ388vd08WBX+Q8v2cJ4YF1/ilq97+bYzM5JuoI9OUfb hw== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3g6rr736sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 May 2022 18:51:02 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id CF84513046;
        Sat, 21 May 2022 18:51:00 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sat, 21 May 2022 06:50:36 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Sat, 21 May 2022 06:50:36 -1200
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sat, 21 May 2022 18:50:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oV4q0uvpnAE6eXSPPMnMlOp+gl6n+5OgpMRfMhkJwbaEhXKQNgKyUhqvEzeYBmzQl1QX/+ebgfdox5e1zRyz0FH3fkBxq2RpCv04bqOB7/ZK79JsyFtmKWjLNePJ8eY4DKJBy9IHtVA/erMO0GqllnlplbOn3zOs1Xo9n8eWjmhTz5Nh7z8OS0Be7jaJB48ApQPfZQpNm/mVDzL6dXCfWFvurK239Ds6QENthx8Iw5wFcLrCnIYhzOr2dKhS76joM/j5qCx/9MhYeim0dBcLkAtzCq1XeYsyBbpLXmoa5t+iVVwXolECkcBaqa23Cj4wP5Z1vWS3/sYvSlaTivMAZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/nb2sdJ017GBg8l5Oko9eF9krsbKwx/8bmgKqM+NbA=;
 b=Tij8XrTv0Y7pgFzyQqoHoc1M5gbwGY6hEoiouXZtKzbeUiPjfke6ZeQ3mAb/9wdPPAFHQqoqluYzsqa/aMv9pKTE6pXHi7NlE7sd55D/OoTgckjviFuYlx0oPuc2JVb84NU4xKkbnaVZBM1/M6m1HB0PECFn34lcYtb8+4JY6x5GRHOq5ZpFGcmEIcyDJgbtXwhxvxecwDU281y2Ykh19hJ9PnIticBV1ffLhPRUfIo3ns716wTTuer2gbb9t7/+gBSFPnIw1ku16+Hvffa7S0CGM+yXwH5KgqWdfOq6Alx5XcyoQj9ccB6NobvlIaNWCTkEy8FwWDz5tAVlMAeqhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from SJ1PR84MB3044.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:45f::6)
 by MW4PR84MB1705.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Sat, 21 May
 2022 18:50:34 +0000
Received: from SJ1PR84MB3044.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f4a7:a91b:7fa0:7d4a]) by SJ1PR84MB3044.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f4a7:a91b:7fa0:7d4a%8]) with mapi id 15.20.5206.024; Sat, 21 May 2022
 18:50:34 +0000
From:   "Travis, Mike" <mike.travis@hpe.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Wahl, Steve" <steve.wahl@hpe.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Travis, Mike" <mike.travis@hpe.com>
Subject: Re: [PATCH] x86/platform/uv: Dont use smp_processor_id while
 preemptable
Thread-Topic: [PATCH] x86/platform/uv: Dont use smp_processor_id while
 preemptable
Thread-Index: AQHYbImZaP+RHM7abU6A9/aPZMC2cq0pXHaAgABRe5Q=
Date:   Sat, 21 May 2022 18:50:34 +0000
Message-ID: <SJ1PR84MB30446EC71AAC4B36B00CFEC8E7D29@SJ1PR84MB3044.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220520203755.266337-1-mike.travis@hpe.com>
 <ed048405-9b22-d0eb-907a-dc00433db507@redhat.com>
In-Reply-To: <ed048405-9b22-d0eb-907a-dc00433db507@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 0ec37663-fccf-9111-fd64-18be3d76e357
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69c38bad-8a13-4b94-b028-08da3b5ac988
x-ms-traffictypediagnostic: MW4PR84MB1705:EE_
x-microsoft-antispam-prvs: <MW4PR84MB17050CAA08A24F6F3729E245E7D29@MW4PR84MB1705.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I7wIRFyDZP2CMSZzlSNbMSUJmXyYjhcYeWiBEW4B/DH+FevCIdj9m+ulncWaYRXJwD4Ibs1HmRDVjqGuvV+2xgrFO7zTRhzI1ikbhIztGRJqvPSj7ZKclt32u23Vv1MFbUj81HQgmXO7xRDFWwYocDUuGPQ0E7KJuvaQ+9YqJwGmpzDS2HdvX0a4OOtV2rynX+Zw9s2wo6LI118JoHiGAFisFJLR1n3tDCzU1i6P4+TDW5lxVI2wysaUSnCWh+3p4dmk6kXUNqFJHS9hTIt8JNlibhonnJdeEfA2BSSpV2vE9/nysa/Ha4/wGLaz77M6jzdCOLWogpzDIArzv5TR+LvUc2chakybJA1UABc4PgkenWWdQPN3BFEog3lVdX0iisQ5ObFriqNlD39+msYqvzJotQhfx5QYHvzQ+e+GGqem3vMo3VPHATHLsk3wb3yc8c97AHj8lxFPnDZKyI5C9xhOyeqY5Nb4yY8a0PTkiAR1QG7XNkcTh+Tn4xTpHq6PYdgzRYTvNblNBBLW5nQUb4eqDR0dj187mizeHO1ShPfIIqQCi1lvtlu/sjzKUlDQKV/JdEMBFdiSQLMYEepL7qPH+tV8M38nwM9wF1BgfptE+DwOUXtbqV5sjfs26g6TOAzACUT/n3kZHWZuK+jXRzidlR0IiJ/ys61KYlqPN7mY+nM4Oy/Xgkj0vFqR2VbpHU8hRcZ6EqnY4a3XdtQMA829zGDw/K8RaoTtY0RAPaE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR84MB3044.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(8676002)(4326008)(38070700005)(66946007)(76116006)(66556008)(64756008)(508600001)(66476007)(66446008)(54906003)(71200400001)(55016003)(82960400001)(110136005)(5660300002)(122000001)(8936002)(52536014)(38100700002)(2906002)(6506007)(186003)(7696005)(53546011)(9686003)(83380400001)(7416002)(86362001)(33656002)(26005)(192303002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QfDRC/HpV40bXJWoTUZDyKNzfCVzQxa5f6/HHDXZoYqhYQZUOXwIzjzwsIBb?=
 =?us-ascii?Q?phprHUm7bQyGhlOrus5g+vm6F7lfSufqNqyouXDhn/UVBkXv4XYq+z7fLTK8?=
 =?us-ascii?Q?LNLb+0r8O5S0UxQvlJQPMZKAYyQz0hWAhViKk5AwhtQkjrWHdLstyffZoQHH?=
 =?us-ascii?Q?uz0SYa7/Qn5TDoAiUzo5PUU1+h5LD9x95YV9Gp8c7SUnqqlB0zWy/hY765MV?=
 =?us-ascii?Q?Nc/JaURb7WOk4XjJqOmW3BCq+J534YHCOQCdZzED8MjlGlLpM81LebTvnsdE?=
 =?us-ascii?Q?0NT2dfJfaq2NLQxECbgcn5rdNlX53ITnixpP1k4exDgD20Z27BNvIN5eWv2R?=
 =?us-ascii?Q?zmaWAmao0VXsZwzMqBs3rBbvOCoPgEi8HOdfP/1Yghr2PK4mCL3sLcYNaemb?=
 =?us-ascii?Q?40OSzqQjaHKacvI4Ow+WZLBrFEgzh9LZfv2SOQ5EwuAfQggeIswpVgxYfS8f?=
 =?us-ascii?Q?Hzm5+xyzeifaNKwwtsy0MvqkGxJ076zPXemv6QzWeknk+/KY+czt2AXsKxCL?=
 =?us-ascii?Q?aB376zUtNMSzjhMww6T0D0p6jpiGk2upliwDMq/MA7iljJd6OR6gP/IXCxRY?=
 =?us-ascii?Q?+LL/YTUiDoMv8DYQ6tBPdNqrRLtwdovelEJpY05oD9VMXcqCntilNd4CyIPu?=
 =?us-ascii?Q?UBHN7VHPaQpx4LYipD5Rbc43S6I2uKgRlittZnrcyfjG4JuZK+Gi5mLLR5hl?=
 =?us-ascii?Q?PkdQptJWR9gvCskITSiQTHFjnwwedcsWghloKAQphq80mOIAycol3tTueXRr?=
 =?us-ascii?Q?ZKjw5khxkcr6/WSU/RN1qN7qpzQC3wi0MKOKW6diAtTrubTCqCVkI+/9vgjf?=
 =?us-ascii?Q?tYOtrl0+4BxhnS87qh8jwHrsxl5HVKAyrb7r5EF+tRL0hsYZ2hSgZ5cORQaH?=
 =?us-ascii?Q?B4Zq/pNU35TWQP2uTLOIWpz45No90IguSUKjO/FWga+ltD1O0ioJmi16TUU/?=
 =?us-ascii?Q?kxP03IA3zyEJuEjjZxTZhNMQhrmKKrQzdp88wGoBqWKRemWueUK3UaMNvRr0?=
 =?us-ascii?Q?scN6YidCele3EOPbDHCw4o0DzlrEVJH8lSYmy1cozrBIbpIO15bP5we6zGY9?=
 =?us-ascii?Q?7G0euONXEUVceM/SAqz06aLwhBeQ7138h7iRNJYUWpmscdvagWLN17is7oFZ?=
 =?us-ascii?Q?vTYySDUCpWvbr4AIJ3gZHWDW/lFbzcJummA7pelbNJYe08pE+qNvak3JkZrK?=
 =?us-ascii?Q?7yQepMHF9Oovpmbp9iK5imyoVTdFqtfwMNkk9zutfFI5jZQbtlPlVJ0emdPj?=
 =?us-ascii?Q?hgurFpxMmR+wugX5GlalLvxRCGv2hwTmjk9uV00cxqQmzL2p5neyyvZ1WDfu?=
 =?us-ascii?Q?T4QstvZgkplz70xUcyQreFW4K74uuL6MxD6uS7i54y2n55A7keCXddrrkDeu?=
 =?us-ascii?Q?dfKGNE6nq31S4AGQLk4wgnbXb5w841iJ/vlPAMU73PTwGITsS6tfkTmXLCfn?=
 =?us-ascii?Q?7sZ+lzRahiEPKmsidlUco/gl6gv7lasYq1mg08xVohufwkIesi80jQgL/Oq0?=
 =?us-ascii?Q?82oLHPFf/mUmZYHoOIzNAhZi9fpndeRCrkvpCrYEVbQaI2Bqm8gL/8WHVyQz?=
 =?us-ascii?Q?3JJSK0ss4fZpZsA+mlTMgaAS9Wbctbt7OvfytecTIxIKf5u7iLetiGI5Bv0h?=
 =?us-ascii?Q?LGwSokWcy0K5aPxtnhS+W9IgOnCp3LNtLq60XPblxHcqpOevkH6DE+hPxQvL?=
 =?us-ascii?Q?qxwCwXG0yU72kn8UnqL5Vh7bPO3mYvtf6wGLY3LgPOmtIJTB3ctiCRSRCHpp?=
 =?us-ascii?Q?EbSQi8o3Sw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR84MB3044.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c38bad-8a13-4b94-b028-08da3b5ac988
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2022 18:50:34.0151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlrinmtQRxytQ6F/Yf1sU6T41Tor/SSJaPb7xUfXZZwTNXc+A5iRVuOBV3fk8AWInTRqSU4DaTvAiNvQ+EbwLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1705
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: BiH1xxJQdHtT47LF9nlkbPunHp29RMBl
X-Proofpoint-ORIG-GUID: BiH1xxJQdHtT47LF9nlkbPunHp29RMBl
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-21_06,2022-05-20_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 clxscore=1011 adultscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205210120
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I'll do that.

________________________________________
From: Hans de Goede <hdegoede@redhat.com>
Sent: Saturday, May 21, 2022 6:57 AM
To: Travis, Mike; Borislav Petkov; Dave Hansen; Ingo Molnar; Thomas Gleixne=
r; Wahl, Steve; x86@kernel.org
Cc: Sivanich, Dimitri; Andy Shevchenko; Darren Hart; H. Peter Anvin; Anders=
on, Russ; linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] x86/platform/uv: Dont use smp_processor_id while preem=
ptable

Hi Mike,

On 5/20/22 22:37, Mike Travis wrote:
> To avoid a "BUG: using smp_processor_id() in preemptible" debug
> warning message, disable preemption around use of the processor id.
>
> Signed-off-by: Mike Travis <mike.travis@hpe.com>
> Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
> Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>

A git blame shows that this code has been around for quite
a while; so presumably this should be backported to some of
the stable kernel series ?

Maybe add an appropriate Cc: stable tag with the range of
kernels this should be added to and/or add a Fixes: tag?

Regards,

Hans


> ---
>  arch/x86/platform/uv/uv_time.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/platform/uv/uv_time.c b/arch/x86/platform/uv/uv_tim=
e.c
> index 54663f3e00cb..094190814a28 100644
> --- a/arch/x86/platform/uv/uv_time.c
> +++ b/arch/x86/platform/uv/uv_time.c
> @@ -275,14 +275,17 @@ static int uv_rtc_unset_timer(int cpu, int force)
>   */
>  static u64 uv_read_rtc(struct clocksource *cs)
>  {
> -     unsigned long offset;
> +     unsigned long offset, time;
> +     unsigned int cpu =3D get_cpu();
>
>       if (uv_get_min_hub_revision_id() =3D=3D 1)
>               offset =3D 0;
>       else
> -             offset =3D (uv_blade_processor_id() * L1_CACHE_BYTES) % PAG=
E_SIZE;
> +             offset =3D (uv_cpu_blade_processor_id(cpu) * L1_CACHE_BYTES=
) % PAGE_SIZE;
>
> -     return (u64)uv_read_local_mmr(UVH_RTC | offset);
> +     time =3D (u64)uv_read_local_mmr(UVH_RTC | offset);
> +     put_cpu();
> +     return time;
>  }
>
>  /*

