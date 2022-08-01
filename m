Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DAE5862AB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 04:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239164AbiHACfg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 31 Jul 2022 22:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239186AbiHACfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:35:18 -0400
Received: from mo-csw.securemx.jp (mo-csw1115.securemx.jp [210.130.202.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94575F8B
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:35:15 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 2712Z2W8008345; Mon, 1 Aug 2022 11:35:02 +0900
X-Iguazu-Qid: 2wHHO7BV2BP5Pw8oLY
X-Iguazu-QSIG: v=2; s=0; t=1659321302; q=2wHHO7BV2BP5Pw8oLY; m=VWKCbd3swS4MQkOZXM8gQUiSHyZhj2fEUdSpPY6AYLE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1112) id 2712Z1mL026867
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 1 Aug 2022 11:35:01 +0900
X-SA-MID: 43019813
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlTxhPd5BbHElnSC9vsrvs92vx/H9bTLooZPXzdFkVQ0Z2WxWC5ihoHCNXAserJVu0cIOIpK9yMNYsYg0fsfB8Ap2gVIl+jtzg9GgJIUagoNWd9OjJMmUITQgZqDkf5pafnHG6tcSC1rJ36jkaSE44bc4e+0sV+erht55NLDZcau/U2wGXcUNrpsTpWr3n4PBMSUjLrtl7ExkunFsMrMIPh5IikQIkMVgiUxtDArBgPNsGMnLdAHZ9ggOUM2fXQU2F3tkaskXxKw+GPPnmceijksVhSU81kyKEkd6kmrXfmW35guYVBiytbw48iY2mZo5UdREUmKkWQXLgycax8EVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2d7pDosfllaY2p3Fj0vFyDQZ9yw1/Xphckf/Ff0iJ+0=;
 b=RnMn7+iTkzMzShbo/Dl8liq1femPh20f/U4hQMYsIcIqb9b0a+YUaCBzgjd49xYm7yjL2fY5OHRAxT+nFm1NMfKQdwtkLuSbirU0HkzK7eAg9br9dffXyfXo0UNizFuixJWgFoVvkqkAo03GY8Spjovt6/imyaLYbSJ5jAD9bWlJYsvh399fEI1paJ6+cgNMeVVs1Vd49qOtwoj9YmVJ19iGHqMQKiVHgIDyITunwUWdzoRjBDysiMj8H8WncOdS1kWKbyNrdnyZi89SY/f38bqjgL1N4DGbPTctN5QfTkZGpnNnAYWtybSnIXgtbdpd76G3fL7Xv1ZpyaGImi3fqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <yuji2.ishikawa@toshiba.co.jp>
To:     <gregkh@linuxfoundation.org>, <oded.gabbay@gmail.com>
CC:     <jiho.chu@samsung.com>, <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>
Subject: RE: New subsystem for acceleration devices
Thread-Topic: New subsystem for acceleration devices
Thread-Index: AQHYpNMiuKJkJQ8DYkaebqXY59xh6q2YnUkAgACqcZA=
Date:   Mon, 1 Aug 2022 02:29:52 +0000
X-TSB-HOP2: ON
Message-ID: <TYAPR01MB62013A228CD094847524F8D8929A9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
References: <CAFCwf11=9qpNAepL7NL+YAV_QO=Wv6pnWPhKHKAepK3fNn+2Dg@mail.gmail.com>
 <YuahxB6geST6ZtGN@kroah.com>
In-Reply-To: <YuahxB6geST6ZtGN@kroah.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e61a0f6-7084-4de0-6467-08da7365b6cb
x-ms-traffictypediagnostic: TY2PR01MB2458:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3WMG0dTUufEJe9nkZw52LlRtxjIc9d2OcDUssVntGrJhrnFCvE3O0p1wasGk35zMHBK4CrDWdHI7jl24LP1+Rd2SzdF/7AHZJELGPyueC+1GbB/CJ9iuOwdNtUUD5yOL5ltcsZgUZFL2/ebrJs9k1kOHsPy4R/jwOSJwbzNSM3TxONbbFuSx4yER5OKCO+PVrP+AXEauwc27BxXsjs9D0713yfWJSeEXWvreUD6cRm/N6sjulqL9tQLnoNRD+IuxIESbfJmn43wbU2E289F6OBegprUvespnPtzR8jyaSsOxnwXvGFdDAoOe1f2M668r5YFbYCH5eJFswPF6ZMheQV9Mx+yvzJ90MkoO/0BVNnBHlwxD1u0cj0RwWbpvsNeQJ5iRkSDFe9BmfN/TW9AnKQYufH2L0sOJPeF+i1irLjuUC/gRj2kTY2dh6j4s7n0q24Ey3MP5gVzI8tfkZ83Q+dbcPYpqd+x+3q3CMRE0Apg1k1WE19VsEjGeDbBXJmigqty6WTeqivJFR687dN6IKn/lYabZIlKDfbaQ0PzM6CCsve2ZOlEWlz6anx8ZOb7PW9lQrcBp9nV2Gd8fG88y2fttWROrODtwSNTaMXwUCbgZ7e5OreoObeLw90lY05h8r6Bdno4GyyP5nam0oLSGs+Pl1ypKI6wZqiWUr5Rnnt2ufDO9IStgxhsM2lEQCzb1Kd4YFmRiqGmq2VOT1i9/ylKty1PPiWOF1Iq3hP5bP/QHVx+ZGu6+yqMatgYR9vXUcbx07M3cK+f5WhJxyQceQojyDSrzWdetHtEx+51BEAl1qepdAFsiZk6QNDga/lVy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6201.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(55016003)(2906002)(5660300002)(33656002)(8936002)(76116006)(4326008)(66446008)(64756008)(66556008)(66476007)(8676002)(66946007)(41300700001)(316002)(110136005)(54906003)(478600001)(6506007)(53546011)(55236004)(71200400001)(7696005)(38100700002)(122000001)(38070700005)(26005)(9686003)(186003)(86362001)(83380400001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?WG14WVc5MUxuN2FBVWVpWUczcFo2a1M5SFNiazhtYy9kZXJ0RTY0VGU5?=
 =?iso-2022-jp?B?MFRXMkdYSHhXR1dDSW5TUmN3Q295ZXNtRm9ROExSNkZYVmtyNnpBSThh?=
 =?iso-2022-jp?B?VGQ3NnFUQmZUaW9aVjdxVTZrR3V3dlF0UDMrZTlyQlRWcndJZUpsYytn?=
 =?iso-2022-jp?B?S2JIMEdyd29ObmZmSnFVMkJJNndqMWNQUkRYNmFNc0VnWmtVS1ZnS2Fx?=
 =?iso-2022-jp?B?NWQ3WUc2bEpPeXBkcHNyNTQrKzFiWVlCT3libmlpQWs5bWtIUFNBWUEw?=
 =?iso-2022-jp?B?MnlpVUZtT3FrdHhSRUhvZzFiUk5yTUpYQW5MVndvMkhLRndCdmZRRE03?=
 =?iso-2022-jp?B?TThBdVdKbGlrTTV4b1dTdTI3YzNUWXBReXMrbUhmQjJPRnlha2FWUFdZ?=
 =?iso-2022-jp?B?RDk2dHFhZFlPVmpoelpEdng2UlZLRGN3UnU4a0twQWZ2VWo4QTFCRGls?=
 =?iso-2022-jp?B?aG1GeDhDOTQxTUxSbkxrWVZjbXNNSzRUNkxOeGk4bzZXTGdoYm9MS2R0?=
 =?iso-2022-jp?B?SmFmeW5CUis1anZLdHROMjFEVGZFd0lXV0lmQUIvSmJLY2RHUi9BaXR4?=
 =?iso-2022-jp?B?TndEU3ZiUEhjeS9qQVFjenpwTTByYmE3Z3hXMFhLbE5lc3ZkZnJJV1NH?=
 =?iso-2022-jp?B?bTFIbGFTanVsYTc3Y2VPQ1hlZzIvMGx4ZjR5eWxzM3FGMkhaeFVuSVlo?=
 =?iso-2022-jp?B?MldYMmZBd2JOQVFzVVQrd0kvSEs5cnUwQjdOVGtHVHRsMFJZOW9zTU9J?=
 =?iso-2022-jp?B?NDNZOFpmWUlLdEYyTHRhMmRIdlpaTk1rQ3pKMXJ6aUVoOEJhKzg1bzhy?=
 =?iso-2022-jp?B?c1JmTnJVcFkxY2wvRHdxR0N5REJTVm0rd0l2S1AvUXh0OFVhcVdwcEZX?=
 =?iso-2022-jp?B?b0c3elVQQytLSHhzZCs3WTFYQWlYcllpR2lDZ29sdy9mNEpFTENZbWcz?=
 =?iso-2022-jp?B?VkxBNUdtWWRISlZrdnZRNm9NR3hNYjVOY1ZEWVhGUFB3ZXdhbTNmNkhn?=
 =?iso-2022-jp?B?RTJtQmpiYTNKdkthekIyQXlibVJyV3F1TUcyL3lJdENBUkRvdHgzK3pa?=
 =?iso-2022-jp?B?WjhiRzhjaWNoYmNNbnVBTUR5VmFweC8yenRidTlmSUE5dC83NkFKL3RG?=
 =?iso-2022-jp?B?a0c0MGJOVXVCT0txWEs4Ny9zdy9KYnlQU0Y1clVGdmMyMWdtRjNuWVM5?=
 =?iso-2022-jp?B?MzIyTTU5Nm1qd0VzNDNOeEI1RzFrQzJxa3Irc2JkK3dlQUF6M3hoN2FE?=
 =?iso-2022-jp?B?TlI5SHpKZlpDbWl0ZUk1akhiaThpM0lROVlUWE1KVjBJR2dKczNzRWg2?=
 =?iso-2022-jp?B?bEVWMHp4SnIybHFuSFM0cDd0UnBmVW0wMTlvcmJGZXprbW54ZnlvbjRN?=
 =?iso-2022-jp?B?Smd1dHJrVkdmRDVhandnWkdhRUhVSWtaWEZKempkWEtzdUNSVmN2UWFV?=
 =?iso-2022-jp?B?UWtMb0Q4TmtabkRwc3pBRm5NZnlHcWs5R01ZNkt3T0gzbG0yMnhlV094?=
 =?iso-2022-jp?B?VDc4ckZQV0lPUytwY3lhWXBpVVN4dVR5THJkazdMQUNNa3pJemNtUEt3?=
 =?iso-2022-jp?B?SzlYNm55N2sydmFFTFpLTHk3ejhuVzZTOFRyTzdaa29nM2hyd05qckhN?=
 =?iso-2022-jp?B?SnhpWS9POFVIbndiSjRkc1FOMU9GVWdRZWZ6QTRSTlJHSGZ4bnl3bTBt?=
 =?iso-2022-jp?B?bFZrRFdvMERWRU9WNysyMk1tTTA5TE4zM0p0MWZvdWpwbVQyVUFzSEUw?=
 =?iso-2022-jp?B?VU41b2Q1Tlg3U3J2b1ptVjF5dzN3a1c3WEgyeWJUOHFKUjJNVzlHMFpi?=
 =?iso-2022-jp?B?WTZ2Zmt1ZWRFRDlFaXlxcm50MElLaVdFaVFRcUNkb3VYbmV2YmNHcmJm?=
 =?iso-2022-jp?B?L3NzZlZxa1pLWUU0QmZRNkx2L2l5ZUpqR3B2RXNDdkVIS2w4aVhzTkxu?=
 =?iso-2022-jp?B?a216a0VSK2xzYjlWRndrNkt0ckl5dnRiZFQwR29RZktxTXpCMnVMeHQy?=
 =?iso-2022-jp?B?dTZYdVJWbXJpZWZTK0hCenl1ZHl5MTlKY1hDRlFSTTVHN0dHcll3MXBQ?=
 =?iso-2022-jp?B?b3BNTXliYXk2NXg2aUNMWU5MV04zT1JscTRLbHFvMHptTlI5Y1hsT1Zt?=
 =?iso-2022-jp?B?S3BoM3ZsdnlNVU9aTk5ubTJqUDU2R2JJNC9vSzFuWS9kZEJpeXBBdmxy?=
 =?iso-2022-jp?B?Z3hvdFEzM0lOZWFFYjFHYmxDUnVZdThxQ040dGtnVk9uVmlPVmMwVkx5?=
 =?iso-2022-jp?B?MXVPckVPekZVNGZHQ0E3K2s4UVovMklvTmo3eGZHVWlxZW9EV2NSeks5?=
 =?iso-2022-jp?B?dWVqRHBPY1BmR3pnUWZhRkVnc0tZbGdSb0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6201.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e61a0f6-7084-4de0-6467-08da7365b6cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 02:29:52.1708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VwVlEBEdQrVzrNcoehJ9x6d99OStKmxaADnEkIn/DK+X6bYNhlR32WYAQupLEN7MSHRYonhNFABs3Wh3RZDkwtEBqDjAYieAPCLEw96tz6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2458
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Monday, August 1, 2022 12:38 AM
> To: Oded Gabbay <oded.gabbay@gmail.com>
> Cc: ishikawa yuji(石川 悠司 ○ＲＤＣ□ＡＩＴＣ○ＥＡ開)
> <yuji2.ishikawa@toshiba.co.jp>; Jiho Chu <jiho.chu@samsung.com>; Arnd
> Bergmann <arnd@arndb.de>; Linux-Kernel@Vger. Kernel. Org
> <linux-kernel@vger.kernel.org>
> Subject: Re: New subsystem for acceleration devices
> 
> On Sun, Jul 31, 2022 at 02:45:34PM +0300, Oded Gabbay wrote:
> > Hi,
> > Greg and I talked a couple of months ago about preparing a new accel
> > subsystem for compute/acceleration devices that are not GPUs and I
> > think your drivers that you are now trying to upstream fit it as well.
> >
> > Would you be open/interested in migrating your drivers to this new
> subsystem ?
> >
> > Because there were no outstanding candidates, I have done so far only
> > a basic and partial implementation of the infrastructure for this
> > subsystem, but if you are willing to join I believe I can finish it
> > rather quickly.
> >
> > At start, the new subsystem will provide only a common device
> > character (e.g. /dev/acX) so everyone will do open/close/ioctl on the
> > same device character. Also sysfs/debugfs entries will be under that
> > device and maybe an IOCTL to retrieve information.
> >
> > In the future I plan to move some of habanalabs driver's code into the
> > subsystem itself, for common tasks such as memory management, dma
> > memory allocation, etc.
> >
> > Of course, you will be able to add your own IOCTLs as you see fit.
> > There will be a range of IOCTLs which are device-specific (similar to
> > drm).
> >
> > wdyt ?
> 
> That sounds reasonable to me as a sane plan forward, thanks for working on
> this.
> 
> greg k-h

Hi,
Thank you for your suggestion.
I'm really interested in the idea to have a dedicated subsystem for accelerators.
Let me challenge if the Visconti DNN driver can be re-written to the framework.
As Visconti SoC has several accelerators as well as DNN,
having a general/common interface will be a big benefit for us to maintain drivers for a long time.

I've heard that the framework has some basic implementation.
Do you have some sample code or enumeration of idea to describe the framework?
Would you share them with me? if that does not bother you.

If you need further information on the current DNN driver, please let me know.
Also, I can provide some for other accelerator drivers which are currently under cleaning up for contribution.

Regards,
	Yuji

