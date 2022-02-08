Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D904AE40F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387716AbiBHW0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386664AbiBHVGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:06:16 -0500
X-Greylist: delayed 321 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 13:06:12 PST
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96434C0612B8;
        Tue,  8 Feb 2022 13:06:12 -0800 (PST)
Received: from [192.168.1.107] ([37.4.249.169]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MtOSu-1oAsVS2ABC-00urlz; Tue, 08 Feb 2022 22:00:24 +0100
Subject: Re: [PATCH v5 04/11] media: bcm2835-unicam: Add support for CCP2/CSI2
 camera interface
To:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Cc:     dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        lukasz@jany.st, mchehab@kernel.org, naush@raspberrypi.com,
        robh@kernel.org, tomi.valkeinen@ideasonboard.com,
        bcm-kernel-feedback-list@broadcom.com
References: <20220208155027.891055-1-jeanmichel.hautbois@ideasonboard.com>
 <20220208155027.891055-5-jeanmichel.hautbois@ideasonboard.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Autocrypt: addr=stefan.wahren@i2se.com; keydata=
 LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tClZlcnNpb246IEdudVBHIHYy
 CgptUUlOQkZ0NmdCTUJFQUN1Yi9wQmV2SHhidkplZnlaRzMySklObW4yYnNFUFgyNVY2ZmVq
 bXlZd21DR0tqRnRMCi9Eb1VNRVZIRHhDSjQ3Qk1YbzM0NGZIVjFDM0FudWRnTjFCZWhMb0J0
 TEh4bW5lQ3pnSDNLY1B0V1c3cHRqNEcKdEp2OUNRRFp5MjdTS29FUHh5YUk4Q0YweWdSeEpj
 NzJNOUk5d21zUFo1YlVIc0x1WVdNcVE3SmNSbVBzNkQ4ZwpCa2srOC95bmdFeU5FeHd4SnBS
 MXlsajVianhXREh5WVF2dUo1THpaS3VPOUxCM2xYVnNjNGJxWEVqYzZWRnVaCkZDQ2svc3lp
 by9ZaHNlOE4rUXN4N01RYWd6NHdLVWtRUWJmWGcxVnFrVG5BaXZYczQyVm5Ja211NWd6SXcv
 MHQKUkp2NTBGUmhIaHhweUtBSThCOG5oTjhRdng3TVZrUGM1dkRmZDN1R1lXNDdKUGhWUUJj
 VXdKd05rLzQ5RjllQQp2ZzJtdE1QRm5GT1JrV1VSdlArRzZGSmZtNitDdk92N1lmUDF1ZXdB
 aTRsbitKTzFnK2dqVklXbC9XSnB5MG5UCmlwZGZlSDlkSGtnU2lmUXVuWWN1Y2lzTXlvUmJG
 OTU1dENna0VZOUVNRWRZMXQ4aUdEaUNnWDZzNTBMSGJpM2sKNDUzdWFjcHhmUVhTYUF3UGtz
 bDhNa0NPc3YyZUVyNElOQ0hZUUR5WmljbEJ1dUNnOEVOYlI2QUdWdFpTUGNRYgplbnpTektS
 Wm9POUNhcUlEK2ZhdkxpQi9kaHptSEErOWJnSWhtWGZ2WFJMRFp6ZThwbzFkeXQzRTFzaFhp
 ZGRaClBBOE51SlZ6RUl0MmxtSTZWOHBaRHBuMjIxcmZLaml2UlFpYW9zNTRUZ1pqak1ZSTdu
 bko3ZTZ4endBUkFRQUIKdENCVGRHVm1ZVzRnVjJGb2NtVnVJRHgzWVdoeVpXNXpkRUJuYlhn
 dWJtVjBQb2tDTndRVEFRZ0FJUVVDWElkYwo0Z0liQXdVTENRZ0hBZ1lWQ0FrS0N3SUVGZ0lE
 QVFJZUFRSVhnQUFLQ1JDVWdld1BFWkR5MjFPVEQvOUdpWkxkCnRSWWNteVJKZ2x0aVFRekFp
 UWRjSUQ3OGxHb1dwL3grci92Y1U2YjZqdVl1ZVR3Z1Iwclc3djdsMklSQnlEN24KSEp4YSt0
 SVNvUVpCZ2hvbE1JZmI5TXRoR09KTENZNzdrL1FoQWhuMzJOR1prZWp3OXR6a3MvNDBtclpT
 VVQ4NApaeWJzUVhyTE0vSFI2VElJL0RlUEIwbktEM0ppcHBzMlVIUUQ5cUQySWpFd1NRUGxI
 akNPckVaaDQ1UFo3bTkrClo5M0x6aVRlc1dabFlRdUxpSndzNHJLcHRIVzFkL3dSZWxzaG1t
 NlFxY0wybDRDL2U0MGVEQjlncTRkU1poOVgKUEVZbGxpeU5RaDdhMkxTZHVtRTFyK2NTd0lq
 RS91ZHRSdmRPOWFLb0psT2JVSzVkTmpTUEg3d0tUYndkWGRZRApHUHdEaFhkNThOQXdyK1BY
 QmxQajB0STFMQ3ErTEJ4ZUt6aFdYK0dWcTlEb2pWanlVREV4Rk5Ga1h1b0M3ZzhtClY5VDB0
 ZUJpdVpSbm91WEt3VjJGcHRaT0hIN0JVRVd0a0t0aGgxZXRmT1dwaWdCemtVN2JQc2ZJWVQr
 cnk5dGIKMW9KK3Y0MVBOYXFaRW1QVXBKeHZmek5UN3Ayd01lRDdaajlmMHJ1YlJQdExBSjJR
 R2pyRkhzdVh3QU9xcHl6ZQoxOEVidHNZazBOMHp1SEVoY2orUEJJQmZoMFlJWWQ1MW9mNkdJ
 aU95UjlxMFhYdHBsVUo3VDIvSDF1UXFrWGxwCitnVzRWa2lmc2NJckl1eWZueFpXMTJlSXZq
 NnlicVdMN2FZS0dZbVQ2aUxDUGJIWXlZY2F5bDRFa0ZjckNGN0UKZTBXVC9zY1ZNaE8vNVgv
 SGFOQTVIQngvcjUycGdMY3Y0aTlNeExRbVUzUmxabUZ1SUZkaGFISmxiaUE4YzNSbApabUZ1
 TG5kaGFISmxia0JwTW5ObExtTnZiVDZKQWpnRUV3RUNBQ0lGQWx0NmdCTUNHd01HQ3drSUJ3
 TUNCaFVJCkFna0tDd1FXQWdNQkFoNEJBaGVBQUFvSkVKU0I3QThSa1BMYmpic1AvamdqYVNz
 NUh0bGtBSXZXUytGcm15N2MKaG5jT0F4TFRWL0Q2UkV3SU95R0poRkt3d29pck55UTJnOXZV
 YTNZQ1lDZjFmSjh3RWhhS09COWQwTHBNUm5MNApkRVQ4ZDgyMzhFL3BLK0hxTktpSXNKaHM2
 SnNLOFpnalZRR3JtbWZua0dyWisxdjBIQnV4ZGljZ0duUC9XdHVBClVsOGw2Mi9BTGJheXlq
 KzYxQ2xyc0V0UklhcU82N0xJWXdQaVBEUkkrWGlNek5pR3pIRi8xUTZHUjAyUkg2YTMKRjg5
 ejhhUHhjSGkxWnZDdDJ5a3o2VUVjaHpQMHI1Z3FGSisvTC9VcHU4ME1YaVk0djVlSWFCNTJn
 VlBnaXlNQQpsTDJkRHMxbUladm5yUkxSWTJ0YjNtQVlOa1Y1QjVJRFQzcGtXeTZrS281T0Nn
 SytZZFlPUjhGTloyb04ydDhPCnJLK1ZudGFLN01NU0tIbG1ZL3NPd3RSbEVoMU9CbXJjQ3dH
 d21wLzA1R2tSNDZmL0lzaFJWZUZPUmF3K0dBcXQKUDIrQ0ZhMkNOQS9JSG5aTm95aWtsRHpQ
 UUhVVUdzck5wcERyaFg5Sm1oQm1nMXYyeXdIMU5YdTFpRGZQMUJBdwpLZ29rdDVmNVVhUkY5
 c0FBNTN2V0V2YlVVTjllZXNGR0x6UFdkSkdRNWhwZC9WSDVJUXk5U0JyaC93SWNla3E1Cm4w
 a042cGJUSHhHRTUyU2kvTVZJa05UdURaM2FwbjJqbERaNHBPdHBCWEkydlAzYlBPK05pcUJa
 anNVM3R4TGkKV2R2MkZqeXp6NlhMUndlV1JZVkw1SGE2TER0eG9yMnZ1NlVQMDdwOXh6MXhS
 WmFPRFczb1lsSEZ6WXBhNFc1ZwpMSGIybEVrSXVVZlNjaWNHYmpqQXRDbFRkR1ZtWVc0Z1Yy
 Rm9jbVZ1SUR4emRHVm1ZVzR1ZDJGb2NtVnVRR2x1CkxYUmxZMmd1WTI5dFBva0NOd1FUQVFn
 QUlRVUNYSWRlaHdJYkF3VUxDUWdIQWdZVkNBa0tDd0lFRmdJREFRSWUKQVFJWGdBQUtDUkNV
 Z2V3UEVaRHkyeUhURC85VUY3UWxEa0d4elE3QWFDSTZOOTVpUWY4LzFvU1VhRE51Mlk2SQpL
 K0R6UXBiMVRiVE9yM1ZKd3dZOGEzT1d6NU5MU09MTVdlVnh0K29zTW1sUUlHdWJEM09EWko4
 aXpQbEcvSnJOCnQ1elNkbU41SUE1ZjNlc1dXUVZLdmdoWkFnVERxZHB2K1pIVzJFbXhuQUox
 dUxGWFhlUWQzVVpjQzVyMy9nL3YKU2FNbzl4ZWszSjVtTnVEbTcxbEVXc0FzL0JBY0ZjK3lu
 TGh4d0JXQld3c3Z3UjhiSHRKNURPTVd2YUt1RHNrcApJR0ZVZS9LYjJCK2pyYXZRM1RuNnMv
 SHFKTTBjZXhTSHo1cGUrMHNHdlArdDlKNzIzNEJGUXdlRkV4cmlleThVCkl4T3I0WEFiYWFi
 U3J5WW5VL3pWSDlVMWkyQUlRWk1XSkFldkN2VmdRL1UrTmVSaFh1ZGU5WVVtRE1EbzJzQjIK
 VkFGRUFxaUYyUVVIUEEybThhN0VPM3lmTDRyTWswaUh6TElLdmg2L3JIOFFDWThpM1h4VE5M
 OWlDTHpCV3UvTgpPbkNBYlMremx2TFphaVNNaDVFZnV4VHR2NFBsVmRFamY2MlArWkhJRDE2
 Z1VEd0VtYXpMQU1yeDY2NmpINWt1ClVDVFZ5bWJMMFR2Qis2TDZBUmw4QU55TTRBRG1rV2tw
 eU0yMmtDdUlTWUFFZlFSM3VXWFo5WWd4YVBNcWJWK3cKQnJoSmc0SGFONkM2eFRxR3YzcjRC
 MmFxYjc3L0NWb1JKMVo5Y3BIQ3dpT3pJYUFtdnl6UFU2TXhDRFhaOEZnWQpsVDR2MjNHNWlt
 SlAyemdYNXMrRjZBQ1VKOVVRUEQwdVRmK0o5RGEycitza2gvc1dPbloreWNvSE5CUXZvY1pF
 Ck5BSFFmN2tDRFFSYmVvQVRBUkFBMkhkMGZzRFZLNzJSTFNESGJ5ME9oZ0RjRGxWQk0yTSto
 WVlwTzNmWDFyKysKc2hpcVBLQ0hWQXNRNWJ4ZTdIbUppbUhhNEtLWXMya3YvbWx0L0NhdUNK
 Ly9wbWN5Y0JNN0d2d25Lem11WHp1QQpHbVZUWkM2V1I1TGtha0ZydEhPelZtc0VHcE52NVJj
 OWw2SFlGcExrYlNrVmk1U1BRWkp5K0VNZ01DRmdqclpmClZGNnlvdHdFMWFmN0hOdE1oTlBh
 TEROMW9VS0Y1aitSeVJnNWl3SnVDRGtuSGp3QlFWNHBndzIvNXZTOEE3WlEKdjJNYlcvVExF
 eXBLWGlmNzhJaGdBelh0RTJYck0xbi9vNlpINzFvUkZGS096NDJsRmR6ZHJTWDBZc3FYZ0hD
 WAo1Z0l0TGZxemoxcHNNYTlvMWVpTlRFbTFkVlFyVHFueXMwbDE4b2FsUk5zd1lsUW1uWUJ3
 cHdDa2FUSExNSHdLCmZHQmJvNWRMUEVzaHRWb3dJNm5zZ3FMVHlRSG1xSFlxVVpZSXBpZ21t
 QzNTd0JXWTFWNmZmVUVta3FwQUFDRW4KTDQvZ1Vnbjd5US81ZDBzZXFuQXEycFNCSE1VVW9D
 Y1R6RVFVV1ZraUR2M1JrN2hURm1oVHNNcTc4eHYyWFJzWApNUjZ5UWhTVFBGWkNZRFVFeEVs
 RXNTbzlGV0hXcjZ6SHlZY2M4cURMRnZHOUZQaG1RdVQyczlCbHg2Z0kzMjNHCm5FcTFsd1dQ
 SlZ6UDRqUWtKS0lBWHdGcHYrVzhDV0xxekRXT3ZkbHJEYVRhVk1zY0ZUZUg1VzZVcHJsNjVq
 cUYKUUdNcGNSR0NzOEdDVVcxM0gwSXlPdFF0d1dYQTRueStTTDgxcHZpQW1hU1hVOGxhS2FS
 dTkxVk9WYUY5ZjRzQQpFUUVBQVlrQ0h3UVlBUUlBQ1FVQ1czcUFFd0liREFBS0NSQ1VnZXdQ
 RVpEeTIrb1hELzljSEhSa0JaT2ZrbVNxCjE0U3Z4MDYyUHRVMEtWNDcwVFNucC9qV29ZSm5L
 SXczRzBtWElSZ3J0SDJkUHdwSWdWanNZeVJTVk1LbVNwdDUKWnJEZjlOdFRiTldnazhWb0xl
 WnpZRW8rSjNvUHFGclRNczNhWVl2N2U0K0pLNjk1WW5tUSttT0Q5bmlhOTE1dApyNUFaajk1
 VWZTVGx5VW15aWMxZDhvdnNmMWZQN1hDVVZSRmNSamZOZkRGMW9ML3BEZ01QNUdaMk93YVRl
 am15CkN1SGpNOElSMUNpYXZCcFlEbUJuVFlrN1B0aHk2YXRXdllsMGZ5L0NxYWpUS3N4Nytw
 OXh6aXU4WmZWWCtpS0IKQ2MrSGUrRURFZEdJRGh2TlovSVFIZk9CMlBVWFdHUytzOUZOVHhy
 L0E2bkxHWG5BOVk2dzkzaVBkWUl3eFM3SwpYTG9LSmVlMTBEamx6c1lzUmZsRk9XMFpPaVNp
 aElDWGlRVjF1cU02dHpGRzlndFJjaXVzNVVBdGhXYU8xT3dVClNDUW1mQ09tNGZ2TUlKSUE5
 cnh0b1M2T3FSUWNpRjNjcm1vMHJKQ3ROMmF3WmZnaThYRWlmN2Q2aGp2MEVLTTkKWFpvaUFa
 WVpEKy9pTG01VGFLV042b0dJdGkwVmpKdjhaWk9aT2ZDYjZ2cUZJa0pXK2FPdTRvclRMRk16
 MjhhbwpVM1F5V3BOQzhGRm1kWXNWdWE4czZnTjFOSWE2eTNxYS9aQjhiQS9pa3k1OUFFejRp
 RElScmdVek1FZzhBazdUCmZtMUtpWWVpVHRCRENvMjVCdlhqYnFzeXhrUUQxbmtSbTZGQVZ6
 RXVPUEllOEp1cVcyeEQ5aXhHWXZqVTVoa1IKZ0pwM2dQNWIrY25HM0xQcXF1UTJFNmdvS1VN
 TEFia0NEUVJiZmw5REFSQUFzRExjYStMbFAydm5mdEVHaHBjQQpCR1ZOUUVGbkdQckNhdVU2
 SGhOODA1V3RQVHRtc1JPdUp6cWdVVDBtcHFXSWZacTZzTXd5dkhLOVRzL0tIM0paClVWYlJD
 M3oyaDNLZmhIL0RhZjk1cGQ2bVBjL2g5dkYvT3kzK2VUV2hnR25QNmNBNWtsUitmTzFXaEc4
 VnJpWHYKck5lUkcyMHN6emplSG9jblNJY1Q1WHVaUjB1REhPaUd4T2l6MXNNUkZUR3h6R095
 MTlSOXJ2dTYzdGlJM2Q3dgpnYzc1T0NBZGtlQi9TZUNFbGFSdzBUZjdMWmJQampzRjI2M0JZ
 bk1mNGtrTkVLdnFXY1UyaWNNcCtxZXpqeW5CCnB2ZXVlMHJDVFFCWUFRbG9GQ1ZUR0hyV1dB
 NkQ0VzVPMkFmSWRJYzF1MUpDWnAyZjVMV1ZvVUZUVklyUW5RUVUKU0hDaWZyOU1aeExUdFBK
 ZFU1Mm9TUHczZGs0aExQOGlKSUx1dnYvYXZhakNzUVlIRXR3WXNiZUZaeGl1TGdscApBN1lj
 Sk5ObXBnQ3BNRDR3VWh2bEN0QUtOQlFXeXIyOTc2OThFUVRuNDZlQmVVNkttMkNpaFhrZ3dD
 eWY4ZXlLCkxFM3NYZXdhcTVrZ1pXdk5xNml1NXFZSVJCOXl3K2NYYzYwZE9aRE9scTkzWDVT
 QVJZemFvZXBrSHo0cmtMa1AKUG8rdENIeUhRUHNHblBYYzlXVDgwREM5Tm5KR2R2VWx5NXJk
 TUk0eHBaeWdlb2tqd293VlFsUFV1Y1M2TXluNwpmOHc4Y2dmQjdDMklBSWNEeDJwUC9IendY
 dmtDT1FOQTdtVjFsTTA4bitnVmtUcnpweGlwNURicTRDSW9ZeDJNCkpaVDhiR1JINlhqY1VE
 S2EwOVFoeVpzQUVRRUFBWWtFUkFRWUFRZ0FEd1VDVzM1ZlF3SWJBZ1VKQThKbkFBSXAKQ1JD
 VWdld1BFWkR5MjhGZElBUVpBUWdBQmdVQ1czNWZRd0FLQ1JCVnhETFBjVk1NamNkc0QvMFJo
 QXN1UVlPeQpyMTNCbDNOaFhrWUFaR3AyWkZER3VrZTdPU2tWOG9qT09UZFR5ei9jT1JHQ2J5
 ZEQrRGd2cUZ5VmRuT1hLZ08wCmxKbUd3ckdlTGRnZ0F2aDBpaHJwNU8wWVVKOWJCU1htR01t
 UVRZSC9BbUxUR2FkYnVqQ1dqNWZGVWtDeXd4aW0KSHV5MFBiMjRwelR2UzUwR1k1WStxSDBG
 SE5haWdka2tpV04zcnVnN0haRXUvQ3lsUFpqT1h6K0QxUVBNckV4dwo3ZC9NS2FiVis5YU5i
 UVlabGRJajk4UXd2VUYxS1N6YThqbFVJdnBoUnEyN0FUOGZER1lHUGZERU1nMmNCT2FlCkty
 N29uUXM0YjdhV082aWZEbHhRVHB6c3pvK0FuODA3Tk1TdFZFRmYrczNBaFZEM2U3bmY4SkJh
 dmJWckFlMGsKb20yNm96elBubnh6K2xxVlZ0dzZVazRYTUl6dGl4L0h3SFl3dUNuY1VYWndL
 MEkzeUFKd2pZd29vck9DaEozUwpFVWJKUVB0R3NneFJERXhWQkZlNk5MUC82MnhQOU82dGFj
 d09kYjBNbVAxYjM5cFJBVEM3YmdkMWxkVUxpNzVaCmxKckowL1NpVkVyb3FOWXk3OXRmbWdB
 WjJVeFptczlTckV5Nm85UVNmc24xYVh2K01QTDlKYUNHbWtQNnpiTFEKTm5kajBKY2FRbmtD
 MHZneWRPMUJtNk11OTZQOXVmbEtaY0FTNndtTE01SWRIT3lqTDg4d0h3anVjakFPQnRjdwpw
 MG9HVG5WT25Sc05ZU084VzhZWi9LZGJ1Nzg1ZGF6TXFKMmlOakFEdUJiZG02TjRqNUVkTW5r
 TG4wQklmUEpwCmRnbTR2bDJVcExqd1JHci9NM3dtbTVwdnMrNnVCN2hrL0ZKaUQvNGxsRU5Q
 NGVNMWg3U200aitWcTZOMSt6VEIKSVhKQWViSXFhc0RwNXlaUzdYcnk0STM2bjg1WEVZZkcw
 MWx0QXlob05WMkRPOFNJUlFwdWkydHErOVJQM1JLMQpKREJ4eEVKWTJFTzVKWjhNeGFQSFEw
 RFQwNWxSRmpLMkFsaGRFSXRqTGpwSjNmVW05c3FMeE1XeHpQNlV6M2lpCjJ1YTR1bnJ0Nk9D
 VHFRd2lqRi8zYlRXaXd2VkFBSG5NRlVpb1hzaEhhb2hWRGNWZm5lSU1mVjBiUUNYWWkzTnAK
 WTB2MFp3Y2lGSCtnU0M3cUQ2WE51aHBWR1NMNElpbGlGeS9TemNhSkV6QUhlTERTaFpQMkNX
 ZG5DNHZnbDM3dApocHg4aDU1WWhKbjZIU3VVelBnaGFLdFZCMmsrajdaZXlaK1NGeHA3SXVi
 SEN3TEhsUWhUNzVSd1EzaUF4S242CjBxajUxY1lUbnF4ZFpYVzZmSDNQa3VNellVNUdwcVIv
 MU9sNWMvd2ZJNmc2QW04eUtXLzBFVUx0K0tuNExGc1MKbTdZM201SDV2MTJVNkpCWXZWK3Ix
 M2paaW9zNEVFREU5M0Q1c05IMk1JeVJ6Q0RxMXpkZHQ0WHV5S0ZqUEtXMQo5aWJaRGZGVjdL
 dUNzdnVMMjNzQmMxc0NNb3ArRTFtVC9ReE9JQTZvRFQxTVFzdHdPVnVReURDdi9PdktTZ2Z6
 CjhGWEdMNkFQY2xqQ3FqOEFKaHhReXN4ZG9pUVA4bS92dStialdHR3Z4dzVzMWxncGlSRFRS
 VVBnY0pKTmFHWTIKVklEclpRaTROU2lOUTBOSWkrZGp1NGZOTW1DcFFxZzh0YkMzY0FhNnl3
 bTZvUUIxU0JobURYMmUxMWdSbGx1SQpPblRHUEUwSFRvM2w3MmxoYmc9PQo9cVpNVgotLS0t
 LUVORCBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCg==
Message-ID: <fc5700c5-0b64-056a-2775-d0ab0f6521e8@i2se.com>
Date:   Tue, 8 Feb 2022 22:00:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220208155027.891055-5-jeanmichel.hautbois@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Provags-ID: V03:K1:wB/q4NgRp2fSuIwaCOxvJD7oSUD2henGhSqHImVf5X4K3lghloc
 q2H74xF5eTl8PcuTuDZya90P7BbCDa9kPVjzGR4DaMICctBLbcNuppvsWHOwjJFftnlKiva
 gyk8zN3qbx076zEitLjaRuqtJm5fBHA9TnDMYh4j33LSV3xEpe5cYR8GTPqPPEUVfk+BITS
 0ldwuxSSrttnoFrnmdZ3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v8NZA2jAhTc=:xx6yEPNFBPANpWfaL5eZ+9
 a6fxzyW1tPOWK66CM1GGtQyqowlIptWGjjqQck2fLZ4FDzBk+IMg6dR6RnGSvj8vXp1+BrCKy
 nlBwYbdHfrN4TNgPm9gGJJ2yXAlrsA0vFDeBaAPszpO8ix4PYLrPBHL/xsTozidJQ/adBhh1h
 5qauKCCHaSSXFpLQkto1KMp4eysbLowddZdJQX8ufyo41ofcPW7yCjN2ACqfaoumrgMiv7HoF
 CVcdMwxyRHH9CSZNGYr2wKGUOEDna2uU04m8KBlKBdzycdpcp1d6CV7+rsvzTvQESxLvdsqEo
 Oyap4E/frs8pUBhtR0nHds7gkyNcbMbW95HBsfPOk4xt+eaSSjxC0oyMBTZLryw85izOwc25t
 acPPu8s69+gfga5qmW66v8pGgjh6JGU3lGvCmPx3D2qjLDoUPnKsen3ePWZHJTmOFv1sfpRqT
 +QRkhsXbIqo3aVvBKaDcz/M/RqiXZxlohVYT+XZfgzKLB9xvEF0Ou5etnUVIgZahEJQJEmK1q
 U6QUTlz6JieJHPEmDGrMDDhOa5ChvU7tVHG1gw0FPoJ0SYPfYobFfMamjzLgGKrpaecZ6smpa
 Ee7mTeCZX5zaILzR/doNOIUUc9XEWfi499jsVh93fWLo+1TQ48G1BkPNT1LMNQ9EWvSNXKAJb
 F9knUdOawXJlLWexWlpExpzIdcqCfALs/nJM7fW/2aG+CMKwTvlchNcamalN5n3PZ1CM7cBLm
 s+f8QvpWKh3dHhIc
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Michel,

Am 08.02.22 um 16:50 schrieb Jean-Michel Hautbois:
> Add driver for the Unicam camera receiver block on BCM283x processors.
> It is represented as two video device nodes: unicam-image and
> unicam-embedded which are connected to an internal subdev (named
> unicam-subdev) in order to manage streams routing.
>
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
>
> ---
> v4:
>   - Add the vendor prefox for DT name
>   - Use the reg-names in DT parsing
>   - Remove MAINTAINERS entry
>
> v3 main changes:
>   - Change code organization
>   - Remove unused variables
>   - Correct the fmt_meta functions
>   - Rewrite the start/stop streaming
>     - You can now start the image node alone, but not the metadata one
>     - The buffers are allocated per-node
>     - only the required stream is started, if the route exists and is
>       enabled
>   - Prefix the macros with UNICAM_ to not have too generic names
>   - Drop colorspace support
>     -> This is causing issues in the try-fmt v4l2-compliance test
>   test VIDIOC_G_FMT: OK
> 	fail: v4l2-test-formats.cpp(363): colorspace >= 0xff
> 	fail: v4l2-test-formats.cpp(465): testColorspace(!node->is_io_mc, pix.pixelformat, pix.colorspace, pix.ycbcr_enc, pix.quantization)
>   test VIDIOC_TRY_FMT: FAIL
> 	fail: v4l2-test-formats.cpp(363): colorspace >= 0xff
> 	fail: v4l2-test-formats.cpp(465): testColorspace(!node->is_io_mc, pix.pixelformat, pix.colorspace, pix.ycbcr_enc, pix.quantization)
>   test VIDIOC_S_FMT: FAIL
>
> v2: Remove the unicam_{info,debug,error} macros and use
> dev_dbg/dev_err instead.
> ---
>  drivers/media/platform/Kconfig                |    1 +
>  drivers/media/platform/Makefile               |    2 +
>  drivers/media/platform/bcm2835/Kconfig        |   21 +
>  drivers/media/platform/bcm2835/Makefile       |    3 +
>  .../platform/bcm2835/bcm2835-unicam-regs.h    |  253 ++
>  .../media/platform/bcm2835/bcm2835-unicam.c   | 2570 +++++++++++++++++
>  6 files changed, 2850 insertions(+)
>  create mode 100644 drivers/media/platform/bcm2835/Kconfig
>  create mode 100644 drivers/media/platform/bcm2835/Makefile
>  create mode 100644 drivers/media/platform/bcm2835/bcm2835-unicam-regs.h
>  create mode 100644 drivers/media/platform/bcm2835/bcm2835-unicam.c
>
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index 9fbdba0fd1e7..033b0358fbb8 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -170,6 +170,7 @@ source "drivers/media/platform/am437x/Kconfig"
>  source "drivers/media/platform/xilinx/Kconfig"
>  source "drivers/media/platform/rcar-vin/Kconfig"
>  source "drivers/media/platform/atmel/Kconfig"
> +source "drivers/media/platform/bcm2835/Kconfig"
>  source "drivers/media/platform/sunxi/Kconfig"
>  
>  config VIDEO_TI_CAL
> diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
> index 28eb4aadbf45..18894fc586aa 100644
> --- a/drivers/media/platform/Makefile
> +++ b/drivers/media/platform/Makefile
> @@ -86,6 +86,8 @@ obj-$(CONFIG_VIDEO_QCOM_CAMSS)		+= qcom/camss/
>  
>  obj-$(CONFIG_VIDEO_QCOM_VENUS)		+= qcom/venus/
>  
> +obj-$(CONFIG_VIDEO_BCM2835_UNICAM)	+= bcm2835/
> +
>  obj-y					+= sunxi/
>  
>  obj-$(CONFIG_VIDEO_MESON_GE2D)		+= meson/ge2d/
> diff --git a/drivers/media/platform/bcm2835/Kconfig b/drivers/media/platform/bcm2835/Kconfig
> new file mode 100644
> index 000000000000..1691541da905
> --- /dev/null
> +++ b/drivers/media/platform/bcm2835/Kconfig
> @@ -0,0 +1,21 @@
> +# Broadcom VideoCore4 V4L2 camera support
> +
> +config VIDEO_BCM2835_UNICAM
> +	tristate "Broadcom BCM283x/BCM271x Unicam video capture driver"
> +	depends on ARCH_BCM2835 || COMPILE_TEST
> +	depends on VIDEO_V4L2
> +	select MEDIA_CONTROLLER
> +	select VIDEO_V4L2_SUBDEV_API
> +	select V4L2_FWNODE
> +	select VIDEOBUF2_DMA_CONTIG
> +	help
> +	  Say Y here to enable support for the BCM283x/BCM271x CSI-2 receiver.
> +	  This is a V4L2 driver that controls the CSI-2 receiver directly,
> +	  independently from the VC4 firmware.
> +	  This driver is mutually exclusive with the use of bcm2835-camera. The
> +	  firmware will disable all access to the peripheral from within the
> +	  firmware if it finds a DT node using it, and bcm2835-camera will
> +	  therefore fail to probe.
> +
> +	  To compile this driver as a module, choose M here. The module will be
> +	  called bcm2835-unicam.
> diff --git a/drivers/media/platform/bcm2835/Makefile b/drivers/media/platform/bcm2835/Makefile
> new file mode 100644
> index 000000000000..a98aba03598a
> --- /dev/null
> +++ b/drivers/media/platform/bcm2835/Makefile
> @@ -0,0 +1,3 @@
> +# Makefile for BCM2835 Unicam driver
> +
> +obj-$(CONFIG_VIDEO_BCM2835_UNICAM) += bcm2835-unicam.o
> diff --git a/drivers/media/platform/bcm2835/bcm2835-unicam-regs.h b/drivers/media/platform/bcm2835/bcm2835-unicam-regs.h
> new file mode 100644
> index 000000000000..b8d297076a02
> --- /dev/null
> +++ b/drivers/media/platform/bcm2835/bcm2835-unicam-regs.h
> @@ -0,0 +1,253 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +/*
> + * Copyright (C) 2017-2020 Raspberry Pi Trading.
> + * Dave Stevenson <dave.stevenson@raspberrypi.com>
> + */
> +
> +#ifndef VC4_REGS_UNICAM_H
> +#define VC4_REGS_UNICAM_H
> +
> +/*
> + * The following values are taken from files found within the code drop
> + * made by Broadcom for the BCM21553 Graphics Driver, predominantly in
> + * brcm_usrlib/dag/vmcsx/vcinclude/hardware_vc4.h.
> + * They have been modified to be only the register offset.
> + */
> +#define UNICAM_CTRL		0x000
> +#define UNICAM_STA		0x004
> +#define UNICAM_ANA		0x008
> +#define UNICAM_PRI		0x00c
> +#define UNICAM_CLK		0x010
> +#define UNICAM_CLT		0x014
> +#define UNICAM_DAT0		0x018
> +#define UNICAM_DAT1		0x01c
> +#define UNICAM_DAT2		0x020
> +#define UNICAM_DAT3		0x024
> +#define UNICAM_DLT		0x028
> +#define UNICAM_CMP0		0x02c
> +#define UNICAM_CMP1		0x030
> +#define UNICAM_CAP0		0x034
> +#define UNICAM_CAP1		0x038
> +#define UNICAM_ICTL		0x100
> +#define UNICAM_ISTA		0x104
> +#define UNICAM_IDI0		0x108
> +#define UNICAM_IPIPE		0x10c
> +#define UNICAM_IBSA0		0x110
> +#define UNICAM_IBEA0		0x114
> +#define UNICAM_IBLS		0x118
> +#define UNICAM_IBWP		0x11c
> +#define UNICAM_IHWIN		0x120
> +#define UNICAM_IHSTA		0x124
> +#define UNICAM_IVWIN		0x128
> +#define UNICAM_IVSTA		0x12c
> +#define UNICAM_ICC		0x130
> +#define UNICAM_ICS		0x134
> +#define UNICAM_IDC		0x138
> +#define UNICAM_IDPO		0x13c
> +#define UNICAM_IDCA		0x140
> +#define UNICAM_IDCD		0x144
> +#define UNICAM_IDS		0x148
> +#define UNICAM_DCS		0x200
> +#define UNICAM_DBSA0		0x204
> +#define UNICAM_DBEA0		0x208
> +#define UNICAM_DBWP		0x20c
> +#define UNICAM_DBCTL		0x300
> +#define UNICAM_IBSA1		0x304
> +#define UNICAM_IBEA1		0x308
> +#define UNICAM_IDI1		0x30c
> +#define UNICAM_DBSA1		0x310
> +#define UNICAM_DBEA1		0x314
> +#define UNICAM_MISC		0x400
> +
> +/*
> + * The following bitmasks are from the kernel released by Broadcom
> + * for Android - https://android.googlesource.com/kernel/bcm/
> + * The Rhea, Hawaii, and Java chips all contain the same VideoCore4
> + * Unicam block as BCM2835, as defined in eg
> + * arch/arm/mach-rhea/include/mach/rdb_A0/brcm_rdb_cam.h and similar.
> + * Values reworked to use the kernel BIT and GENMASK macros.
> + *
> + * Some of the bit mnenomics have been amended to match the datasheet.
> + */
> +/* UNICAM_CTRL Register */
> +#define UNICAM_CPE		BIT(0)
> +#define UNICAM_MEM		BIT(1)
> +#define UNICAM_CPR		BIT(2)
> +#define UNICAM_CPM_MASK		GENMASK(3, 3)
> +#define UNICAM_CPM_CSI2		0
> +#define UNICAM_CPM_CCP2		1
> +#define UNICAM_SOE		BIT(4)
> +#define UNICAM_DCM_MASK		GENMASK(5, 5)
> +#define UNICAM_DCM_STROBE	0
> +#define UNICAM_DCM_DATA		1
> +#define UNICAM_SLS		BIT(6)
> +#define UNICAM_PFT_MASK		GENMASK(11, 8)
> +#define UNICAM_OET_MASK		GENMASK(20, 12)
> +
> +/* UNICAM_STA Register */
> +#define UNICAM_SYN		BIT(0)
> +#define UNICAM_CS		BIT(1)
> +#define UNICAM_SBE		BIT(2)
> +#define UNICAM_PBE		BIT(3)
> +#define UNICAM_HOE		BIT(4)
> +#define UNICAM_PLE		BIT(5)
> +#define UNICAM_SSC		BIT(6)
> +#define UNICAM_CRCE		BIT(7)
> +#define UNICAM_OES		BIT(8)
> +#define UNICAM_IFO		BIT(9)
> +#define UNICAM_OFO		BIT(10)
> +#define UNICAM_BFO		BIT(11)
> +#define UNICAM_DL		BIT(12)
> +#define UNICAM_PS		BIT(13)
> +#define UNICAM_IS		BIT(14)
> +#define UNICAM_PI0		BIT(15)
> +#define UNICAM_PI1		BIT(16)
> +#define UNICAM_FSI_S		BIT(17)
> +#define UNICAM_FEI_S		BIT(18)
> +#define UNICAM_LCI_S		BIT(19)
> +#define UNICAM_BUF0_RDY		BIT(20)
> +#define UNICAM_BUF0_NO		BIT(21)
> +#define UNICAM_BUF1_RDY		BIT(22)
> +#define UNICAM_BUF1_NO		BIT(23)
> +#define UNICAM_DI		BIT(24)
> +
> +#define UNICAM_STA_MASK_ALL \
> +		(UNICAM_DL | \
> +		UNICAM_SBE | \
> +		UNICAM_PBE | \
> +		UNICAM_HOE | \
> +		UNICAM_PLE | \
> +		UNICAM_SSC | \
> +		UNICAM_CRCE | \
> +		UNICAM_IFO | \
> +		UNICAM_OFO | \
> +		UNICAM_PS | \
> +		UNICAM_PI0 | \
> +		UNICAM_PI1)
> +
> +/* UNICAM_ANA Register */
> +#define UNICAM_APD		BIT(0)
> +#define UNICAM_BPD		BIT(1)
> +#define UNICAM_AR		BIT(2)
> +#define UNICAM_DDL		BIT(3)
> +#define UNICAM_CTATADJ_MASK	GENMASK(7, 4)
> +#define UNICAM_PTATADJ_MASK	GENMASK(11, 8)
> +
> +/* UNICAM_PRI Register */
> +#define UNICAM_PE		BIT(0)
> +#define UNICAM_PT_MASK		GENMASK(2, 1)
> +#define UNICAM_NP_MASK		GENMASK(7, 4)
> +#define UNICAM_PP_MASK		GENMASK(11, 8)
> +#define UNICAM_BS_MASK		GENMASK(15, 12)
> +#define UNICAM_BL_MASK		GENMASK(17, 16)
> +
> +/* UNICAM_CLK Register */
> +#define UNICAM_CLE		BIT(0)
> +#define UNICAM_CLPD		BIT(1)
> +#define UNICAM_CLLPE		BIT(2)
> +#define UNICAM_CLHSE		BIT(3)
> +#define UNICAM_CLTRE		BIT(4)
> +#define UNICAM_CLAC_MASK	GENMASK(8, 5)
> +#define UNICAM_CLSTE		BIT(29)
> +
> +/* UNICAM_CLT Register */
> +#define UNICAM_CLT1_MASK	GENMASK(7, 0)
> +#define UNICAM_CLT2_MASK	GENMASK(15, 8)
> +
> +/* UNICAM_DATn Registers */
> +#define UNICAM_DLE		BIT(0)
> +#define UNICAM_DLPD		BIT(1)
> +#define UNICAM_DLLPE		BIT(2)
> +#define UNICAM_DLHSE		BIT(3)
> +#define UNICAM_DLTRE		BIT(4)
> +#define UNICAM_DLSM		BIT(5)
> +#define UNICAM_DLFO		BIT(28)
> +#define UNICAM_DLSTE		BIT(29)
> +
> +#define UNICAM_DAT_MASK_ALL	(UNICAM_DLSTE | UNICAM_DLFO)
> +
> +/* UNICAM_DLT Register */
> +#define UNICAM_DLT1_MASK	GENMASK(7, 0)
> +#define UNICAM_DLT2_MASK	GENMASK(15, 8)
> +#define UNICAM_DLT3_MASK	GENMASK(23, 16)
> +
> +/* UNICAM_ICTL Register */
> +#define UNICAM_FSIE		BIT(0)
> +#define UNICAM_FEIE		BIT(1)
> +#define UNICAM_IBOB		BIT(2)
> +#define UNICAM_FCM		BIT(3)
> +#define UNICAM_TFC		BIT(4)
> +#define UNICAM_LIP_MASK		GENMASK(6, 5)
> +#define UNICAM_LCIE_MASK	GENMASK(28, 16)
> +
> +/* UNICAM_IDI0/1 Register */
> +#define UNICAM_ID0_MASK		GENMASK(7, 0)
> +#define UNICAM_ID1_MASK		GENMASK(15, 8)
> +#define UNICAM_ID2_MASK		GENMASK(23, 16)
> +#define UNICAM_ID3_MASK		GENMASK(31, 24)
> +
> +/* UNICAM_ISTA Register */
> +#define UNICAM_FSI		BIT(0)
> +#define UNICAM_FEI		BIT(1)
> +#define UNICAM_LCI		BIT(2)
> +
> +#define UNICAM_ISTA_MASK_ALL	(UNICAM_FSI | UNICAM_FEI | UNICAM_LCI)
> +
> +/* UNICAM_IPIPE Register */
> +#define UNICAM_PUM_MASK		GENMASK(2, 0)
> +/* Unpacking modes */
> +#define UNICAM_PUM_NONE		0
> +#define UNICAM_PUM_UNPACK6	1
> +#define UNICAM_PUM_UNPACK7	2
> +#define UNICAM_PUM_UNPACK8	3
> +#define UNICAM_PUM_UNPACK10	4
> +#define UNICAM_PUM_UNPACK12	5
> +#define UNICAM_PUM_UNPACK14	6
> +#define UNICAM_PUM_UNPACK16	7
> +#define UNICAM_DDM_MASK		GENMASK(6, 3)
> +#define UNICAM_PPM_MASK		GENMASK(9, 7)
> +/* Packing modes */
> +#define UNICAM_PPM_NONE		0
> +#define UNICAM_PPM_PACK8	1
> +#define UNICAM_PPM_PACK10	2
> +#define UNICAM_PPM_PACK12	3
> +#define UNICAM_PPM_PACK14	4
> +#define UNICAM_PPM_PACK16	5
> +#define UNICAM_DEM_MASK		GENMASK(11, 10)
> +#define UNICAM_DEBL_MASK	GENMASK(14, 12)
> +#define UNICAM_ICM_MASK		GENMASK(16, 15)
> +#define UNICAM_IDM_MASK		GENMASK(17, 17)
> +
> +/* UNICAM_ICC Register */
> +#define UNICAM_ICFL_MASK	GENMASK(4, 0)
> +#define UNICAM_ICFH_MASK	GENMASK(9, 5)
> +#define UNICAM_ICST_MASK	GENMASK(12, 10)
> +#define UNICAM_ICLT_MASK	GENMASK(15, 13)
> +#define UNICAM_ICLL_MASK	GENMASK(31, 16)
> +
> +/* UNICAM_DCS Register */
> +#define UNICAM_DIE		BIT(0)
> +#define UNICAM_DIM		BIT(1)
> +#define UNICAM_DBOB		BIT(3)
> +#define UNICAM_FDE		BIT(4)
> +#define UNICAM_LDP		BIT(5)
> +#define UNICAM_EDL_MASK		GENMASK(15, 8)
> +
> +/* UNICAM_DBCTL Register */
> +#define UNICAM_DBEN		BIT(0)
> +#define UNICAM_BUF0_IE		BIT(1)
> +#define UNICAM_BUF1_IE		BIT(2)
> +
> +/* UNICAM_CMP[0,1] register */
> +#define UNICAM_PCE		BIT(31)
> +#define UNICAM_GI		BIT(9)
> +#define UNICAM_CPH		BIT(8)
> +#define UNICAM_PCVC_MASK	GENMASK(7, 6)
> +#define UNICAM_PCDT_MASK	GENMASK(5, 0)
> +
> +/* UNICAM_MISC register */
> +#define UNICAM_FL0		BIT(6)
> +#define UNICAM_FL1		BIT(9)
> +
> +#endif
> diff --git a/drivers/media/platform/bcm2835/bcm2835-unicam.c b/drivers/media/platform/bcm2835/bcm2835-unicam.c
> new file mode 100644
> index 000000000000..470e691637c7
> --- /dev/null
> +++ b/drivers/media/platform/bcm2835/bcm2835-unicam.c
> @@ -0,0 +1,2570 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * BCM283x / BCM271x Unicam Capture Driver
> + *
> + * Copyright (C) 2017-2020 - Raspberry Pi (Trading) Ltd.
> + *
> + * Dave Stevenson <dave.stevenson@raspberrypi.com>
> + *
> + * Based on TI am437x driver by
> + *   Benoit Parrot <bparrot@ti.com>
> + *   Lad, Prabhakar <prabhakar.csengg@gmail.com>
> + *
> + * and TI CAL camera interface driver by
> + *    Benoit Parrot <bparrot@ti.com>
> + *
> + *
> + * There are two camera drivers in the kernel for BCM283x - this one
> + * and bcm2835-camera (currently in staging).
> + *
> + * This driver directly controls the Unicam peripheral - there is no
> + * involvement with the VideoCore firmware. Unicam receives CSI-2 or
> + * CCP2 data and writes it into SDRAM.
> + * The only potential processing options are to repack Bayer data into an
> + * alternate format, and applying windowing.
> + * The repacking does not shift the data, so can repack V4L2_PIX_FMT_Sxxxx10P
> + * to V4L2_PIX_FMT_Sxxxx10, or V4L2_PIX_FMT_Sxxxx12P to V4L2_PIX_FMT_Sxxxx12,
> + * but not generically up to V4L2_PIX_FMT_Sxxxx16. The driver will add both
> + * formats where the relevant formats are defined, and will automatically
> + * configure the repacking as required.
> + * Support for windowing may be added later.
> + *
> + * It should be possible to connect this driver to any sensor with a
> + * suitable output interface and V4L2 subdevice driver.
> + *
> + * bcm2835-camera uses the VideoCore firmware to control the sensor,
> + * Unicam, ISP, and all tuner control loops. Fully processed frames are
> + * delivered to the driver by the firmware. It only has sensor drivers
> + * for Omnivision OV5647, and Sony IMX219 sensors.
> + *
> + * The two drivers are mutually exclusive for the same Unicam instance.
> + * The VideoCore firmware checks the device tree configuration during boot.
> + * If it finds device tree nodes called csi0 or csi1 it will block the
> + * firmware from accessing the peripheral, and bcm2835-camera will
> + * not be able to stream data.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_graph.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +#include <linux/videodev2.h>
> +
> +#include <media/v4l2-async.h>
> +#include <media/v4l2-common.h>
> +#include <media/v4l2-ctrls.h>
> +#include <media/v4l2-dev.h>
> +#include <media/v4l2-device.h>
> +#include <media/v4l2-dv-timings.h>
> +#include <media/v4l2-event.h>
> +#include <media/v4l2-ioctl.h>
> +#include <media/v4l2-fwnode.h>
> +#include <media/v4l2-mc.h>
> +#include <media/videobuf2-dma-contig.h>
> +
> +#include "bcm2835-unicam-regs.h"
> +
> +#define UNICAM_MODULE_NAME	"unicam"
> +
> +/*
> + * Unicam must request a minimum of 250Mhz from the VPU clock.
> + * Otherwise the input FIFOs overrun and cause image corruption.
> + */
> +#define UNICAM_MIN_VPU_CLOCK_RATE (250 * 1000 * 1000)
> +
> +/*
> + * Stride is a 16 bit register, but also has to be a multiple of 32.
> + */
> +#define UNICAM_BPL_ALIGNMENT		32
> +#define UNICAM_MAX_BYTESPERLINE		((1 << 16) - UNICAM_BPL_ALIGNMENT)
> +/*
> + * Max width is therefore determined by the max stride divided by
> + * the number of bits per pixel. Take 32bpp as a
> + * worst case.
> + * No imposed limit on the height, so adopt a square image for want
> + * of anything better.
> + */
> +#define UNICAM_MAX_WIDTH		(UNICAM_MAX_BYTESPERLINE / 4)
> +#define UNICAM_MAX_HEIGHT		UNICAM_MAX_WIDTH
> +/* Define a nominal minimum image size */
> +#define UNICAM_MIN_WIDTH		16
> +#define UNICAM_MIN_HEIGHT		16
> +/* Default size of the embedded buffer */
> +#define UNICAM_EMBEDDED_SIZE		16384
> +
> +/*
> + * Size of the dummy buffer. Can be any size really, but the DMA
> + * allocation works in units of page sizes.
> + */
> +#define UNICAM_DUMMY_BUF_SIZE		PAGE_SIZE
> +
> +#define UNICAM_SD_PAD_SINK		0
> +#define UNICAM_SD_PAD_SOURCE_IMAGE	1
> +#define UNICAM_SD_PAD_SOURCE_METADATA	2
> +#define UNICAM_SD_NUM_PADS		(1 + UNICAM_SD_PAD_SOURCE_METADATA)
> +
> +static inline bool unicam_sd_pad_is_sink(u32 pad)
> +{
> +	/* Camera RX has 1 sink pad, and N source pads */
> +	return pad == 0;
> +}
> +
> +static inline bool unicam_sd_pad_is_source(u32 pad)
> +{
> +	/* Camera RX has 1 sink pad, and N source pads */
> +	return pad != UNICAM_SD_PAD_SINK;
> +}
> +
> +enum unicam_node_type {
> +	UNICAM_IMAGE_NODE,
> +	UNICAM_METADATA_NODE,
> +	UNICAM_MAX_NODES
> +};
> +
> +/* -----------------------------------------------------------------------------
> + * Structure definitions
> + */
> +
> +/*
> + * struct unicam_fmt - Unicam media bus format information
> + * @fourcc: V4L2 pixel format FCC identifier. 0 if n/a.
> + * @unpacked_fourcc: V4L2 pixel format FCC identifier if the data is expanded
> + * out to 16bpp. 0 if n/a.
> + * @code: V4L2 media bus format code.
> + * @depth: Bits per pixel as delivered from the source.
> + * @csi_dt: CSI data type.
> + * @metadata_fmt: This format only applies to the metadata pad.
> + */
> +struct unicam_fmt {
> +	u32	fourcc;
> +	u32	unpacked_fourcc;
> +	u32	code;
> +	u8	depth;
> +	u8	csi_dt;
> +	u8	metadata_fmt:1;
> +};
> +
> +static const struct unicam_fmt unicam_image_formats[] = {
> +	/* YUV Formats */
> +	{
> +		.fourcc		= V4L2_PIX_FMT_YUYV,
> +		.code		= MEDIA_BUS_FMT_YUYV8_1X16,
> +		.depth		= 16,
> +		.csi_dt		= 0x1e,
> +	}, {
> +		.fourcc		= V4L2_PIX_FMT_UYVY,
> +		.code		= MEDIA_BUS_FMT_UYVY8_1X16,
> +		.depth		= 16,
> +		.csi_dt		= 0x1e,
> +	}, {
> +		.fourcc		= V4L2_PIX_FMT_YVYU,
> +		.code		= MEDIA_BUS_FMT_YVYU8_1X16,
> +		.depth		= 16,
> +		.csi_dt		= 0x1e,
> +	}, {
> +		.fourcc		= V4L2_PIX_FMT_VYUY,
> +		.code		= MEDIA_BUS_FMT_VYUY8_1X16,
> +		.depth		= 16,
> +		.csi_dt		= 0x1e,
> +	}, {
> +	/* RGB Formats */
> +		.fourcc		= V4L2_PIX_FMT_RGB565, /* gggbbbbb rrrrrggg */
> +		.code		= MEDIA_BUS_FMT_RGB565_1X16,
> +		.depth		= 16,
> +		.csi_dt		= 0x22,
> +	}, {
> +		.fourcc		= V4L2_PIX_FMT_RGB24, /* rgb */
> +		.code		= MEDIA_BUS_FMT_RGB888_1X24,
> +		.depth		= 24,
> +		.csi_dt		= 0x24,
> +	}, {
> +		.fourcc		= V4L2_PIX_FMT_BGR24, /* bgr */
> +		.code		= MEDIA_BUS_FMT_BGR888_1X24,
> +		.depth		= 24,
> +		.csi_dt		= 0x24,
> +	}, {
> +	/* Bayer Formats */
> +		.fourcc		= V4L2_PIX_FMT_SBGGR8,
> +		.code		= MEDIA_BUS_FMT_SBGGR8_1X8,
> +		.depth		= 8,
> +		.csi_dt		= 0x2a,
> +	}, {
> +		.fourcc		= V4L2_PIX_FMT_SGBRG8,
> +		.code		= MEDIA_BUS_FMT_SGBRG8_1X8,
> +		.depth		= 8,
> +		.csi_dt		= 0x2a,
> +	}, {
> +		.fourcc		= V4L2_PIX_FMT_SGRBG8,
> +		.code		= MEDIA_BUS_FMT_SGRBG8_1X8,
> +		.depth		= 8,
> +		.csi_dt		= 0x2a,
> +	}, {
> +		.fourcc		= V4L2_PIX_FMT_SRGGB8,
> +		.code		= MEDIA_BUS_FMT_SRGGB8_1X8,
> +		.depth		= 8,
> +		.csi_dt		= 0x2a,
> +	}, {
> +		.fourcc		= V4L2_PIX_FMT_SBGGR10P,
> +		.unpacked_fourcc = V4L2_PIX_FMT_SBGGR10,
> +		.code		= MEDIA_BUS_FMT_SBGGR10_1X10,
> +		.depth		= 10,
> +		.csi_dt		= 0x2b,
> +	}, {
> +		.fourcc		= V4L2_PIX_FMT_SGBRG10P,
> +		.unpacked_fourcc = V4L2_PIX_FMT_SGBRG10,
> +		.code		= MEDIA_BUS_FMT_SGBRG10_1X10,
> +		.depth		= 10,
> +		.csi_dt		= 0x2b,
> +	}, {
> +		.fourcc		= V4L2_PIX_FMT_SGRBG10P,
> +		.unpacked_fourcc = V4L2_PIX_FMT_SGRBG10,
> +		.code		= MEDIA_BUS_FMT_SGRBG10_1X10,
> +		.depth		= 10,
> +		.csi_dt		= 0x2b,
> +	}, {
> +		.fourcc		= V4L2_PIX_FMT_SRGGB10P,
> +		.unpacked_fourcc = V4L2_PIX_FMT_SRGGB10,
> +		.code		= MEDIA_BUS_FMT_SRGGB10_1X10,
> +		.depth		= 10,
> +		.csi_dt		= 0x2b,
> +	}, {
> +		.fourcc		= V4L2_PIX_FMT_SBGGR12P,
> +		.unpacked_fourcc = V4L2_PIX_FMT_SBGGR12,
> +		.code		= MEDIA_BUS_FMT_SBGGR12_1X12,
> +		.depth		= 12,
> +		.csi_dt		= 0x2c,
> +	}, {
> +		.fourcc		= V4L2_PIX_FMT_SGBRG12P,
> +		.unpacked_fourcc = V4L2_PIX_FMT_SGBRG12,
> +		.code		= MEDIA_BUS_FMT_SGBRG12_1X12,
> +		.depth		= 12,
> +		.csi_dt		= 0x2c,
> +	}, {
> +		.fourcc		= V4L2_PIX_FMT_SGRBG12P,
> +		.unpacked_fourcc = V4L2_PIX_FMT_SGRBG12,
> +		.code		= MEDIA_BUS_FMT_SGRBG12_1X12,
> +		.depth		= 12,
> +		.csi_dt		= 0x2c,
> +	}, {
> +		.fourcc		= V4L2_PIX_FMT_SRGGB12P,
> +		.unpacked_fourcc = V4L2_PIX_FMT_SRGGB12,
> +		.code		= MEDIA_BUS_FMT_SRGGB12_1X12,
> +		.depth		= 12,
> +		.csi_dt		= 0x2c,
> +	}, {
> +		.fourcc		= V4L2_PIX_FMT_SBGGR14P,
> +		.unpacked_fourcc = V4L2_PIX_FMT_SBGGR14,
> +		.code		= MEDIA_BUS_FMT_SBGGR14_1X14,
> +		.depth		= 14,
> +		.csi_dt		= 0x2d,
> +	}, {
> +		.fourcc		= V4L2_PIX_FMT_SGBRG14P,
> +		.unpacked_fourcc = V4L2_PIX_FMT_SGBRG14,
> +		.code		= MEDIA_BUS_FMT_SGBRG14_1X14,
> +		.depth		= 14,
> +		.csi_dt		= 0x2d,
> +	}, {
> +		.fourcc		= V4L2_PIX_FMT_SGRBG14P,
> +		.unpacked_fourcc = V4L2_PIX_FMT_SGRBG14,
> +		.code		= MEDIA_BUS_FMT_SGRBG14_1X14,
> +		.depth		= 14,
> +		.csi_dt		= 0x2d,
> +	}, {
> +		.fourcc		= V4L2_PIX_FMT_SRGGB14P,
> +		.unpacked_fourcc = V4L2_PIX_FMT_SRGGB14,
> +		.code		= MEDIA_BUS_FMT_SRGGB14_1X14,
> +		.depth		= 14,
> +		.csi_dt		= 0x2d,
> +	}, {
> +	/* 16 bit Bayer formats could be supported. */
> +
> +	/* Greyscale formats */
> +		.fourcc		= V4L2_PIX_FMT_GREY,
> +		.code		= MEDIA_BUS_FMT_Y8_1X8,
> +		.depth		= 8,
> +		.csi_dt		= 0x2a,
> +	}, {
> +		.fourcc		= V4L2_PIX_FMT_Y10P,
> +		.unpacked_fourcc = V4L2_PIX_FMT_Y10,
> +		.code		= MEDIA_BUS_FMT_Y10_1X10,
> +		.depth		= 10,
> +		.csi_dt		= 0x2b,
> +	}, {
> +		.fourcc		= V4L2_PIX_FMT_Y12P,
> +		.unpacked_fourcc = V4L2_PIX_FMT_Y12,
> +		.code		= MEDIA_BUS_FMT_Y12_1X12,
> +		.depth		= 12,
> +		.csi_dt		= 0x2c,
> +	}, {
> +		.fourcc		= V4L2_PIX_FMT_Y14P,
> +		.unpacked_fourcc = V4L2_PIX_FMT_Y14,
> +		.code		= MEDIA_BUS_FMT_Y14_1X14,
> +		.depth		= 14,
> +		.csi_dt		= 0x2d,
> +	},
> +};
> +
> +static const struct unicam_fmt unicam_meta_formats[] = {
> +	{
> +		.fourcc		= V4L2_META_FMT_8,
> +		.code		= MEDIA_BUS_FMT_METADATA_8,
> +		.depth		= 8,
> +		.metadata_fmt	= 1,
> +	}
> +};
> +
> +static const struct v4l2_mbus_framefmt default_image_format = {
> +	.width = 640,
> +	.height = 480,
> +	.code = MEDIA_BUS_FMT_UYVY8_1X16,
> +	.field = V4L2_FIELD_NONE,
> +	.colorspace = V4L2_COLORSPACE_SRGB,
> +	.ycbcr_enc = V4L2_YCBCR_ENC_601,
> +	.quantization = V4L2_QUANTIZATION_LIM_RANGE,
> +	.xfer_func = V4L2_XFER_FUNC_SRGB,
> +	.flags = 0,
> +};
> +
> +struct unicam_buffer {
> +	struct vb2_v4l2_buffer vb;
> +	struct list_head list;
> +};
> +
> +static inline struct unicam_buffer *to_unicam_buffer(struct vb2_buffer *vb)
> +{
> +	return container_of(vb, struct unicam_buffer, vb.vb2_buf);
> +}
> +
> +struct unicam_node {
> +	bool registered;
> +	bool streaming;
> +	unsigned int id;
> +
> +	/* Pointer to the current v4l2_buffer */
> +	struct unicam_buffer *cur_frm;
> +	/* Pointer to the next v4l2_buffer */
> +	struct unicam_buffer *next_frm;
> +	/* video capture */
> +	const struct unicam_fmt *fmt;
> +	/* Used to store current pixel format */
> +	struct v4l2_format v_fmt;
> +	/* Buffer queue used in video-buf */
> +	struct vb2_queue buffer_queue;
> +	/* Queue of filled frames */
> +	struct list_head dma_queue;
> +	/* IRQ lock for DMA queue */
> +	spinlock_t dma_queue_lock;
> +	/* lock used to access this structure */
> +	struct mutex lock;
> +	/* Identifies video device for this channel */
> +	struct video_device video_dev;
> +	/* Pointer to the parent handle */
> +	struct unicam_device *dev;
> +	struct media_pad pad;
> +	/*
> +	 * Dummy buffer intended to be used by unicam
> +	 * if we have no other queued buffers to swap to.
> +	 */
> +	void *dummy_buf_cpu_addr;
> +	dma_addr_t dummy_buf_dma_addr;
> +};
> +
> +struct unicam_device {
> +	struct kref kref;
> +
> +	/* peripheral base address */
> +	void __iomem *base;
> +	/* clock gating base address */
> +	void __iomem *clk_gate_base;
> +	/* lp clock handle */
> +	struct clk *clock;
> +	/* vpu clock handle */
> +	struct clk *vpu_clock;
> +	/* V4l2 device */
> +	struct v4l2_device v4l2_dev;
> +	struct media_device mdev;
> +
> +	/* parent device */
> +	struct device *dev;
> +	/* subdevice async Notifier */
> +	struct v4l2_async_notifier notifier;
> +	unsigned int sequence;
> +
> +	/* Sensor node */
> +	struct {
> +		struct v4l2_subdev *subdev;
> +		struct media_pad *pad;
> +	} sensor;
> +
> +	/* Internal subdev */
> +	struct {
> +		struct v4l2_subdev sd;
> +		struct media_pad pads[UNICAM_SD_NUM_PADS];
> +		bool streaming;
> +	} subdev;
> +
> +	enum v4l2_mbus_type bus_type;
> +	/*
> +	 * Stores bus.mipi_csi2.flags for CSI2 sensors, or
> +	 * bus.mipi_csi1.strobe for CCP2.
> +	 */
> +	unsigned int bus_flags;
> +	unsigned int max_data_lanes;
> +	unsigned int active_data_lanes;
> +
> +	struct media_pipeline pipe;
> +
> +	struct unicam_node node[UNICAM_MAX_NODES];
> +};
> +
> +static inline struct unicam_device *
> +notifier_to_unicam_device(struct v4l2_async_notifier *notifier)
> +{
> +	return container_of(notifier, struct unicam_device, notifier);
> +}
> +
> +static inline struct unicam_device *
> +sd_to_unicam_device(struct v4l2_subdev *sd)
> +{
> +	return container_of(sd, struct unicam_device, subdev.sd);
> +}
> +
> +static void unicam_release(struct kref *kref)
> +{
> +	struct unicam_device *unicam =
> +		container_of(kref, struct unicam_device, kref);
> +
> +	if (unicam->mdev.dev)
> +		media_device_cleanup(&unicam->mdev);
> +
> +	kfree(unicam);
> +}
> +
> +static void unicam_put(struct unicam_device *unicam)
> +{
> +	kref_put(&unicam->kref, unicam_release);
> +}
> +
> +static struct unicam_device *unicam_get(struct unicam_device *unicam)
> +{
> +	kref_get(&unicam->kref);
> +	return unicam;
> +}
> +
> +static void unicam_node_release(struct video_device *vdev)
> +{
> +	struct unicam_node *node = video_get_drvdata(vdev);
> +
> +	unicam_put(node->dev);
> +}
> +
> +/* -----------------------------------------------------------------------------
> + * Misc helper functions
> + */
> +
> +static inline bool is_metadata_node(struct unicam_node *node)
> +{
> +	return node->video_dev.device_caps & V4L2_CAP_META_CAPTURE;
> +}
> +
> +static inline bool is_image_node(struct unicam_node *node)
> +{
> +	return node->video_dev.device_caps & V4L2_CAP_VIDEO_CAPTURE;
> +}
> +
> +/* Hardware access */
> +static inline void unicam_clk_write(struct unicam_device *unicam, u32 val)
> +{
> +	/* Pass the CM_PASSWORD along with the value. */
> +	writel(val | 0x5a000000, unicam->clk_gate_base);
> +}
> +
> +static inline u32 unicam_reg_read(struct unicam_device *unicam, u32 offset)
> +{
> +	return readl(unicam->base + offset);
> +}
> +
> +static inline void unicam_reg_write(struct unicam_device *unicam, u32 offset, u32 val)
> +{
> +	writel(val, unicam->base + offset);
> +}
> +
> +static inline int unicam_get_field(u32 value, u32 mask)
> +{
> +	return (value & mask) >> __ffs(mask);
> +}
> +
> +static inline void unicam_set_field(u32 *valp, u32 field, u32 mask)
> +{
> +	u32 val = *valp;
> +
> +	val &= ~mask;
> +	val |= (field << __ffs(mask)) & mask;
> +	*valp = val;
> +}
> +
> +static inline void unicam_reg_write_field(struct unicam_device *unicam, u32 offset,
> +					  u32 field, u32 mask)
> +{
> +	u32 val = unicam_reg_read(unicam, offset);
> +
> +	unicam_set_field(&val, field, mask);
> +	unicam_reg_write(unicam, offset, val);
> +}
> +
> +/* -----------------------------------------------------------------------------
> + * Format data table and helper functions
> + */
> +
> +/* Format setup functions */
> +static const struct unicam_fmt *unicam_find_format_by_code(u32 code, u32 pad)
> +{
> +	const struct unicam_fmt *formats;
> +	unsigned int num_formats;
> +	unsigned int i;
> +
> +	if (pad == UNICAM_SD_PAD_SOURCE_IMAGE) {
> +		formats = unicam_image_formats;
> +		num_formats = ARRAY_SIZE(unicam_image_formats);
> +	} else {
> +		formats = unicam_meta_formats;
> +		num_formats = ARRAY_SIZE(unicam_meta_formats);
> +	}
> +
> +	for (i = 0; i < num_formats; i++) {
> +		if (formats[i].code == code)
> +			return &formats[i];
> +	}
> +
> +	return NULL;
> +}
> +
> +static const struct unicam_fmt *unicam_find_format_by_fourcc(u32 fourcc, u32 pad)
> +{
> +	const struct unicam_fmt *formats;
> +	unsigned int num_formats;
> +	unsigned int i;
> +
> +	if (pad == UNICAM_SD_PAD_SOURCE_IMAGE) {
> +		formats = unicam_image_formats;
> +		num_formats = ARRAY_SIZE(unicam_image_formats);
> +	} else {
> +		formats = unicam_meta_formats;
> +		num_formats = ARRAY_SIZE(unicam_meta_formats);
> +	}
> +
> +	for (i = 0; i < num_formats; ++i) {
> +		if (formats[i].fourcc == fourcc)
> +			return &formats[i];
> +	}
> +
> +	return NULL;
> +}
> +
> +static int unicam_calc_format_size_bpl(struct unicam_device *unicam,
> +				       const struct unicam_fmt *fmt,
> +				       struct v4l2_format *f)
> +{
> +	u32 min_bpl;
> +
> +	v4l_bound_align_image(&f->fmt.pix.width, UNICAM_MIN_WIDTH,
> +			      UNICAM_MAX_WIDTH, 2,
> +			      &f->fmt.pix.height, UNICAM_MIN_HEIGHT,
> +			      UNICAM_MAX_HEIGHT, 0, 0);
> +
> +	/* Unpacking always goes to 16bpp */
> +	if (f->fmt.pix.pixelformat == fmt->unpacked_fourcc)
> +		min_bpl = f->fmt.pix.width * 2;
> +	else
> +		min_bpl = f->fmt.pix.width * fmt->depth / 8;
> +	min_bpl = ALIGN(min_bpl, UNICAM_BPL_ALIGNMENT);
> +
> +	f->fmt.pix.bytesperline = ALIGN(f->fmt.pix.bytesperline,
> +					UNICAM_BPL_ALIGNMENT);
> +	f->fmt.pix.bytesperline = clamp_t(unsigned int,
> +					  f->fmt.pix.bytesperline,
> +					  min_bpl,
> +					  UNICAM_MAX_BYTESPERLINE);
> +
> +	f->fmt.pix.sizeimage = f->fmt.pix.height * f->fmt.pix.bytesperline;
> +
> +	dev_dbg(unicam->dev, "%s: fourcc: %08X size: %ux%u bpl:%u img_size:%u\n",
> +		__func__,
> +		f->fmt.pix.pixelformat,
> +		f->fmt.pix.width, f->fmt.pix.height,
> +		f->fmt.pix.bytesperline, f->fmt.pix.sizeimage);
> +
> +	return 0;
> +}
> +
> +/* -----------------------------------------------------------------------------
> + * Hardware handling
> + */
> +
> +static void unicam_wr_dma_addr(struct unicam_node *node, dma_addr_t dmaaddr,
> +			       unsigned int buffer_size)
> +{
> +	dma_addr_t endaddr = dmaaddr + buffer_size;
> +
> +	if (node->id == UNICAM_IMAGE_NODE) {
> +		unicam_reg_write(node->dev, UNICAM_IBSA0, dmaaddr);
> +		unicam_reg_write(node->dev, UNICAM_IBEA0, endaddr);
> +	} else {
> +		unicam_reg_write(node->dev, UNICAM_DBSA0, dmaaddr);
> +		unicam_reg_write(node->dev, UNICAM_DBEA0, endaddr);
> +	}
> +}
> +
> +static unsigned int unicam_get_lines_done(struct unicam_device *unicam)
> +{
> +	dma_addr_t start_addr, cur_addr;
> +	struct unicam_node *node = &unicam->node[UNICAM_IMAGE_NODE];
> +	unsigned int stride = node->v_fmt.fmt.pix.bytesperline;
> +	struct unicam_buffer *frm = node->cur_frm;
> +
> +	if (!frm)
> +		return 0;
> +
> +	start_addr = vb2_dma_contig_plane_dma_addr(&frm->vb.vb2_buf, 0);
> +	cur_addr = unicam_reg_read(unicam, UNICAM_IBWP);
> +	return (unsigned int)(cur_addr - start_addr) / stride;
> +}
> +
> +static void unicam_schedule_next_buffer(struct unicam_node *node)
> +{
> +	struct unicam_buffer *buf;
> +	unsigned int size;
> +	dma_addr_t addr;
> +
> +	buf = list_first_entry(&node->dma_queue, struct unicam_buffer, list);
> +	node->next_frm = buf;
> +	list_del(&buf->list);
> +
> +	addr = vb2_dma_contig_plane_dma_addr(&buf->vb.vb2_buf, 0);
> +	if (is_image_node(node))
> +		size = node->v_fmt.fmt.pix.sizeimage;
> +	else
> +		size = node->v_fmt.fmt.meta.buffersize;
> +
> +	unicam_wr_dma_addr(node, addr, size);
> +}
> +
> +static void unicam_schedule_dummy_buffer(struct unicam_node *node)
> +{
> +	struct unicam_device *unicam = node->dev;
> +	int node_id = is_image_node(node) ? UNICAM_IMAGE_NODE : UNICAM_METADATA_NODE;
> +
> +	dev_dbg(unicam->dev, "Scheduling dummy buffer for node %d\n", node_id);
> +
> +	unicam_wr_dma_addr(node, node->dummy_buf_dma_addr,
> +			   UNICAM_DUMMY_BUF_SIZE);
> +
> +	node->next_frm = NULL;
> +}
> +
> +static void unicam_process_buffer_complete(struct unicam_node *node,
> +					   unsigned int sequence)
> +{
> +	node->cur_frm->vb.field = node->v_fmt.fmt.pix.field;
> +	node->cur_frm->vb.sequence = sequence;
> +
> +	vb2_buffer_done(&node->cur_frm->vb.vb2_buf, VB2_BUF_STATE_DONE);
> +}
> +
> +static void unicam_queue_event_sof(struct unicam_device *unicam)
> +{
> +	struct unicam_node *node = &unicam->node[UNICAM_IMAGE_NODE];
> +
> +	struct v4l2_event event = {
> +		.type = V4L2_EVENT_FRAME_SYNC,
> +		.u.frame_sync.frame_sequence = unicam->sequence,
> +	};
> +
> +	v4l2_event_queue(&node->video_dev, &event);
> +}
> +
> +/*
> + * unicam_isr : ISR handler for unicam capture
> + * @irq: irq number
> + * @dev_id: dev_id ptr
> + *
> + * It changes status of the captured buffer, takes next buffer from the queue
> + * and sets its address in unicam registers
> + */
> +static irqreturn_t unicam_isr(int irq, void *dev)
> +{
> +	struct unicam_device *unicam = dev;
> +	unsigned int lines_done = unicam_get_lines_done(dev);
> +	unsigned int sequence = unicam->sequence;
> +	unsigned int i;
> +	u32 ista, sta;
> +	bool fe;
> +	u64 ts;
> +
> +	sta = unicam_reg_read(unicam, UNICAM_STA);
> +	/* Write value back to clear the interrupts */
> +	unicam_reg_write(unicam, UNICAM_STA, sta);
> +
> +	ista = unicam_reg_read(unicam, UNICAM_ISTA);
> +	/* Write value back to clear the interrupts */
> +	unicam_reg_write(unicam, UNICAM_ISTA, ista);
> +
> +	dev_dbg(unicam->dev, "ISR: ISTA: 0x%X, STA: 0x%X, sequence %d, lines done %d",
> +		ista, sta, sequence, lines_done);
> +
> +	if (!(sta & (UNICAM_IS | UNICAM_PI0)))
> +		return IRQ_HANDLED;
> +
> +	/*
> +	 * Look for either the Frame End interrupt or the Packet Capture status
> +	 * to signal a frame end.
> +	 */
> +	fe = ista & UNICAM_FEI || sta & UNICAM_PI0;
> +
> +	/*
> +	 * We must run the frame end handler first. If we have a valid next_frm
> +	 * and we get a simultaneout FE + FS interrupt, running the FS handler
> +	 * first would null out the next_frm ptr and we would have lost the
> +	 * buffer forever.
> +	 */
> +	if (fe) {
> +		/*
> +		 * Ensure we have swapped buffers already as we can't
> +		 * stop the peripheral. If no buffer is available, use a
> +		 * dummy buffer to dump out frames until we get a new buffer
> +		 * to use.
> +		 */
> +		for (i = 0; i < ARRAY_SIZE(unicam->node); i++) {
> +			if (!unicam->node[i].streaming)
> +				continue;
> +
> +			/*
> +			 * If cur_frm == next_frm, it means we have not had
> +			 * a chance to swap buffers, likely due to having
> +			 * multiple interrupts occurring simultaneously (like FE
> +			 * + FS + LS). In this case, we cannot signal the buffer
> +			 * as complete, as the HW will reuse that buffer.
> +			 */
> +			if (unicam->node[i].cur_frm &&
> +			    unicam->node[i].cur_frm != unicam->node[i].next_frm)
> +				unicam_process_buffer_complete(&unicam->node[i],
> +							       sequence);
> +			unicam->node[i].cur_frm = unicam->node[i].next_frm;
> +		}
> +		unicam->sequence++;
> +	}
> +
> +	if (ista & UNICAM_FSI) {
> +		/*
> +		 * Timestamp is to be when the first data byte was captured,
> +		 * aka frame start.
> +		 */
> +		ts = ktime_get_ns();
> +		for (i = 0; i < ARRAY_SIZE(unicam->node); i++) {
> +			if (!unicam->node[i].streaming)
> +				continue;
> +
> +			if (unicam->node[i].cur_frm)
> +				unicam->node[i].cur_frm->vb.vb2_buf.timestamp =
> +								ts;
> +			else
> +				dev_dbg(unicam->v4l2_dev.dev,
> +					"ISR: [%d] Dropping frame, buffer not available at FS\n",
> +					i);
> +			/*
> +			 * Set the next frame output to go to a dummy frame
> +			 * if we have not managed to obtain another frame
> +			 * from the queue.
> +			 */
> +			unicam_schedule_dummy_buffer(&unicam->node[i]);
> +		}
> +
> +		unicam_queue_event_sof(unicam);
> +	}
> +
> +	/*
> +	 * Cannot swap buffer at frame end, there may be a race condition
> +	 * where the HW does not actually swap it if the new frame has
> +	 * already started.
> +	 */
> +	if (ista & (UNICAM_FSI | UNICAM_LCI) && !fe) {
> +		for (i = 0; i < ARRAY_SIZE(unicam->node); i++) {
> +			if (!unicam->node[i].streaming)
> +				continue;
> +
> +			spin_lock(&unicam->node[i].dma_queue_lock);
> +			if (!list_empty(&unicam->node[i].dma_queue) &&
> +			    !unicam->node[i].next_frm)
> +				unicam_schedule_next_buffer(&unicam->node[i]);
> +			spin_unlock(&unicam->node[i].dma_queue_lock);
> +		}
> +	}
> +
> +	if (unicam_reg_read(unicam, UNICAM_ICTL) & UNICAM_FCM) {
> +		/* Switch out of trigger mode if selected */
> +		unicam_reg_write_field(unicam, UNICAM_ICTL, 1, UNICAM_TFC);
> +		unicam_reg_write_field(unicam, UNICAM_ICTL, 0, UNICAM_FCM);
> +	}
> +	return IRQ_HANDLED;
> +}
> +
> +static void unicam_set_packing_config(struct unicam_device *unicam)
> +{
> +	struct unicam_node *node = &unicam->node[UNICAM_IMAGE_NODE];
> +	u32 pack, unpack;
> +	u32 val;
> +
> +	if (node->v_fmt.fmt.pix.pixelformat ==
> +	    node->fmt->fourcc) {
> +		unpack = UNICAM_PUM_NONE;
> +		pack = UNICAM_PPM_NONE;
> +	} else {
> +		switch (node->fmt->depth) {
> +		case 8:
> +			unpack = UNICAM_PUM_UNPACK8;
> +			break;
> +		case 10:
> +			unpack = UNICAM_PUM_UNPACK10;
> +			break;
> +		case 12:
> +			unpack = UNICAM_PUM_UNPACK12;
> +			break;
> +		case 14:
> +			unpack = UNICAM_PUM_UNPACK14;
> +			break;
> +		case 16:
> +			unpack = UNICAM_PUM_UNPACK16;
> +			break;
> +		default:
> +			unpack = UNICAM_PUM_NONE;
> +			break;
> +		}
> +
> +		/* Repacking is always to 16bpp */
> +		pack = UNICAM_PPM_PACK16;
> +	}
> +
> +	val = 0;
> +	unicam_set_field(&val, unpack, UNICAM_PUM_MASK);
> +	unicam_set_field(&val, pack, UNICAM_PPM_MASK);
> +	unicam_reg_write(unicam, UNICAM_IPIPE, val);
> +}
> +
> +static void unicam_cfg_image_id(struct unicam_device *unicam)
> +{
> +	struct unicam_node *node = &unicam->node[UNICAM_IMAGE_NODE];
> +
> +	if (unicam->bus_type == V4L2_MBUS_CSI2_DPHY) {
> +		/* CSI2 mode, hardcode VC 0 for now. */
> +		unicam_reg_write(unicam, UNICAM_IDI0,
> +				 (0 << 6) | node->fmt->csi_dt);
> +	} else {
> +		/* CCP2 mode */
> +		unicam_reg_write(unicam, UNICAM_IDI0,
> +				 0x80 | node->fmt->csi_dt);
> +	}
> +}
> +
> +static void unicam_enable_ed(struct unicam_device *unicam)
> +{
> +	u32 val = unicam_reg_read(unicam, UNICAM_DCS);
> +
> +	unicam_set_field(&val, 2, UNICAM_EDL_MASK);
> +	/* Do not wrap at the end of the embedded data buffer */
> +	unicam_set_field(&val, 0, UNICAM_DBOB);
> +
> +	unicam_reg_write(unicam, UNICAM_DCS, val);
> +}
> +
> +static void unicam_start_rx(struct unicam_device *unicam, dma_addr_t *addr)
> +{
> +	struct unicam_node *node = &unicam->node[UNICAM_IMAGE_NODE];
> +	int line_int_freq = node->v_fmt.fmt.pix.height >> 2;
> +	unsigned int size, i;
> +	u32 val;
> +
> +	if (line_int_freq < 128)
> +		line_int_freq = 128;
> +
> +	/* Enable lane clocks */
> +	val = 1;
> +	for (i = 0; i < unicam->active_data_lanes; i++)
> +		val = val << 2 | 1;
> +	unicam_clk_write(unicam, val);
> +
> +	/* Basic init */
> +	unicam_reg_write(unicam, UNICAM_CTRL, UNICAM_MEM);
> +
> +	/* Enable analogue control, and leave in reset. */
> +	val = UNICAM_AR;
> +	unicam_set_field(&val, 7, UNICAM_CTATADJ_MASK);
> +	unicam_set_field(&val, 7, UNICAM_PTATADJ_MASK);
> +	unicam_reg_write(unicam, UNICAM_ANA, val);
> +	usleep_range(1000, 2000);
> +
> +	/* Come out of reset */
> +	unicam_reg_write_field(unicam, UNICAM_ANA, 0, UNICAM_AR);
> +
> +	/* Peripheral reset */
> +	unicam_reg_write_field(unicam, UNICAM_CTRL, 1, UNICAM_CPR);
> +	unicam_reg_write_field(unicam, UNICAM_CTRL, 0, UNICAM_CPR);
> +
> +	unicam_reg_write_field(unicam, UNICAM_CTRL, 0, UNICAM_CPE);
> +
> +	/* Enable Rx control. */
> +	val = unicam_reg_read(unicam, UNICAM_CTRL);
> +	if (unicam->bus_type == V4L2_MBUS_CSI2_DPHY) {
> +		unicam_set_field(&val, UNICAM_CPM_CSI2, UNICAM_CPM_MASK);
> +		unicam_set_field(&val, UNICAM_DCM_STROBE, UNICAM_DCM_MASK);
> +	} else {
> +		unicam_set_field(&val, UNICAM_CPM_CCP2, UNICAM_CPM_MASK);
> +		unicam_set_field(&val, unicam->bus_flags, UNICAM_DCM_MASK);
> +	}
> +	/* Packet framer timeout */
> +	unicam_set_field(&val, 0xf, UNICAM_PFT_MASK);
> +	unicam_set_field(&val, 128, UNICAM_OET_MASK);
> +	unicam_reg_write(unicam, UNICAM_CTRL, val);
> +
> +	unicam_reg_write(unicam, UNICAM_IHWIN, 0);
> +	unicam_reg_write(unicam, UNICAM_IVWIN, 0);
> +
> +	/* AXI bus access QoS setup */
> +	val = unicam_reg_read(unicam, UNICAM_PRI);
> +	unicam_set_field(&val, 0, UNICAM_BL_MASK);
> +	unicam_set_field(&val, 0, UNICAM_BS_MASK);
> +	unicam_set_field(&val, 0xe, UNICAM_PP_MASK);
> +	unicam_set_field(&val, 8, UNICAM_NP_MASK);
> +	unicam_set_field(&val, 2, UNICAM_PT_MASK);
> +	unicam_set_field(&val, 1, UNICAM_PE);
> +	unicam_reg_write(unicam, UNICAM_PRI, val);
> +
> +	unicam_reg_write_field(unicam, UNICAM_ANA, 0, UNICAM_DDL);
> +
> +	/* Always start in trigger frame capture mode (UNICAM_FCM set) */
> +	val = UNICAM_FSIE | UNICAM_FEIE | UNICAM_FCM | UNICAM_IBOB;
> +	unicam_set_field(&val, line_int_freq, UNICAM_LCIE_MASK);
> +	unicam_reg_write(unicam, UNICAM_ICTL, val);
> +	unicam_reg_write(unicam, UNICAM_STA, UNICAM_STA_MASK_ALL);
> +	unicam_reg_write(unicam, UNICAM_ISTA, UNICAM_ISTA_MASK_ALL);
> +
> +	/* tclk_term_en */
> +	unicam_reg_write_field(unicam, UNICAM_CLT, 2, UNICAM_CLT1_MASK);
> +	/* tclk_settle */
> +	unicam_reg_write_field(unicam, UNICAM_CLT, 6, UNICAM_CLT2_MASK);
> +	/* td_term_en */
> +	unicam_reg_write_field(unicam, UNICAM_DLT, 2, UNICAM_DLT1_MASK);
> +	/* ths_settle */
> +	unicam_reg_write_field(unicam, UNICAM_DLT, 6, UNICAM_DLT2_MASK);
> +	/* trx_enable */
> +	unicam_reg_write_field(unicam, UNICAM_DLT, 0, UNICAM_DLT3_MASK);
> +
> +	unicam_reg_write_field(unicam, UNICAM_CTRL, 0, UNICAM_SOE);
> +
> +	/* Packet compare setup - required to avoid missing frame ends */
> +	val = 0;
> +	unicam_set_field(&val, 1, UNICAM_PCE);
> +	unicam_set_field(&val, 1, UNICAM_GI);
> +	unicam_set_field(&val, 1, UNICAM_CPH);
> +	unicam_set_field(&val, 0, UNICAM_PCVC_MASK);
> +	unicam_set_field(&val, 1, UNICAM_PCDT_MASK);
> +	unicam_reg_write(unicam, UNICAM_CMP0, val);
> +
> +	/* Enable clock lane and set up terminations */
> +	val = 0;
> +	if (unicam->bus_type == V4L2_MBUS_CSI2_DPHY) {
> +		/* CSI2 */
> +		unicam_set_field(&val, 1, UNICAM_CLE);
> +		unicam_set_field(&val, 1, UNICAM_CLLPE);
> +		if (unicam->bus_flags & V4L2_MBUS_CSI2_CONTINUOUS_CLOCK) {
> +			unicam_set_field(&val, 1, UNICAM_CLTRE);
> +			unicam_set_field(&val, 1, UNICAM_CLHSE);
> +		}
> +	} else {
> +		/* CCP2 */
> +		unicam_set_field(&val, 1, UNICAM_CLE);
> +		unicam_set_field(&val, 1, UNICAM_CLHSE);
> +		unicam_set_field(&val, 1, UNICAM_CLTRE);
> +	}
> +	unicam_reg_write(unicam, UNICAM_CLK, val);
> +
> +	/*
> +	 * Enable required data lanes with appropriate terminations.
> +	 * The same value needs to be written to UNICAM_DATn registers for
> +	 * the active lanes, and 0 for inactive ones.
> +	 */
> +	val = 0;
> +	if (unicam->bus_type == V4L2_MBUS_CSI2_DPHY) {
> +		/* CSI2 */
> +		unicam_set_field(&val, 1, UNICAM_DLE);
> +		unicam_set_field(&val, 1, UNICAM_DLLPE);
> +		if (unicam->bus_flags & V4L2_MBUS_CSI2_CONTINUOUS_CLOCK) {
> +			unicam_set_field(&val, 1, UNICAM_DLTRE);
> +			unicam_set_field(&val, 1, UNICAM_DLHSE);
> +		}
> +	} else {
> +		/* CCP2 */
> +		unicam_set_field(&val, 1, UNICAM_DLE);
> +		unicam_set_field(&val, 1, UNICAM_DLHSE);
> +		unicam_set_field(&val, 1, UNICAM_DLTRE);
> +	}
> +	unicam_reg_write(unicam, UNICAM_DAT0, val);
> +
> +	if (unicam->active_data_lanes == 1)
> +		val = 0;
> +	unicam_reg_write(unicam, UNICAM_DAT1, val);
> +
> +	if (unicam->max_data_lanes > 2) {
> +		/*
> +		 * Registers UNICAM_DAT2 and UNICAM_DAT3 only valid if the
> +		 * instance supports more than 2 data lanes.
> +		 */
> +		if (unicam->active_data_lanes == 2)
> +			val = 0;
> +		unicam_reg_write(unicam, UNICAM_DAT2, val);
> +
> +		if (unicam->active_data_lanes == 3)
> +			val = 0;
> +		unicam_reg_write(unicam, UNICAM_DAT3, val);
> +	}
> +
> +	unicam_reg_write(unicam, UNICAM_IBLS,
> +			 node->v_fmt.fmt.pix.bytesperline);
> +	size = node->v_fmt.fmt.pix.sizeimage;
> +	unicam_wr_dma_addr(&unicam->node[UNICAM_IMAGE_NODE],
> +			   addr[UNICAM_IMAGE_NODE], size);
> +	unicam_set_packing_config(unicam);
> +	unicam_cfg_image_id(unicam);
> +
> +	val = unicam_reg_read(unicam, UNICAM_MISC);
> +	unicam_set_field(&val, 1, UNICAM_FL0);
> +	unicam_set_field(&val, 1, UNICAM_FL1);
> +	unicam_reg_write(unicam, UNICAM_MISC, val);
> +
> +	/* Enable peripheral */
> +	unicam_reg_write_field(unicam, UNICAM_CTRL, 1, UNICAM_CPE);
> +
> +	/* Load image pointers */
> +	unicam_reg_write_field(unicam, UNICAM_ICTL, 1, UNICAM_LIP_MASK);
> +
> +	/*
> +	 * Enable trigger only for the first frame to
> +	 * sync correctly to the FS from the source.
> +	 */
> +	unicam_reg_write_field(unicam, UNICAM_ICTL, 1, UNICAM_TFC);
> +}
> +
> +static void unicam_start_metadata(struct unicam_device *unicam, dma_addr_t *addr)
> +{
> +	struct unicam_node *node = &unicam->node[UNICAM_METADATA_NODE];
> +	unsigned int size;
> +
> +	dev_dbg(unicam->dev, "enable metadata dma\n");
> +	size = node->v_fmt.fmt.meta.buffersize;
> +	unicam_enable_ed(unicam);
> +	unicam_wr_dma_addr(node, addr[UNICAM_METADATA_NODE], size);
> +	unicam_reg_write_field(unicam, UNICAM_DCS, 1, UNICAM_LDP);
> +}
> +
> +static void unicam_disable(struct unicam_device *unicam)
> +{
> +	/* Analogue lane control disable */
> +	unicam_reg_write_field(unicam, UNICAM_ANA, 1, UNICAM_DDL);
> +
> +	/* Stop the output engine */
> +	unicam_reg_write_field(unicam, UNICAM_CTRL, 1, UNICAM_SOE);
> +
> +	/* Disable the data lanes. */
> +	unicam_reg_write(unicam, UNICAM_DAT0, 0);
> +	unicam_reg_write(unicam, UNICAM_DAT1, 0);
> +
> +	if (unicam->max_data_lanes > 2) {
> +		unicam_reg_write(unicam, UNICAM_DAT2, 0);
> +		unicam_reg_write(unicam, UNICAM_DAT3, 0);
> +	}
> +
> +	/* Peripheral reset */
> +	unicam_reg_write_field(unicam, UNICAM_CTRL, 1, UNICAM_CPR);
> +	usleep_range(50, 100);
> +	unicam_reg_write_field(unicam, UNICAM_CTRL, 0, UNICAM_CPR);
> +
> +	/* Disable peripheral */
> +	unicam_reg_write_field(unicam, UNICAM_CTRL, 0, UNICAM_CPE);
> +
> +	/* Clear ED setup */
> +	unicam_reg_write(unicam, UNICAM_DCS, 0);
> +
> +	/* Disable all lane clocks */
> +	unicam_clk_write(unicam, 0);
> +}
> +
> +/* -----------------------------------------------------------------------------
> + * V4L2 subdev Operations
> + */
> +
> +static int __unicam_subdev_set_routing(struct v4l2_subdev *sd,
> +				       struct v4l2_subdev_state *state,
> +				       struct v4l2_subdev_krouting *routing)
> +{
> +	int ret;
> +
> +	ret = v4l2_subdev_routing_validate_1_to_1(routing);
> +	if (ret)
> +		return ret;
> +
> +	v4l2_subdev_lock_state(state);
> +
> +	ret = v4l2_subdev_set_routing(sd, state, routing);
> +
> +	v4l2_subdev_unlock_state(state);
> +
> +	return ret;
> +}
> +
> +static int unicam_subdev_set_routing(struct v4l2_subdev *sd,
> +				     struct v4l2_subdev_state *state,
> +				     enum v4l2_subdev_format_whence which,
> +				     struct v4l2_subdev_krouting *routing)
> +{
> +	struct unicam_device *unicam = sd_to_unicam_device(sd);
> +
> +	if (which == V4L2_SUBDEV_FORMAT_ACTIVE && unicam->subdev.streaming)
> +		return -EBUSY;
> +
> +	return __unicam_subdev_set_routing(sd, state, routing);
> +}
> +
> +static int unicam_subdev_init_cfg(struct v4l2_subdev *sd,
> +				  struct v4l2_subdev_state *state)
> +{
> +	struct v4l2_subdev_route routes[] = {
> +		{
> +			.sink_pad = UNICAM_SD_PAD_SINK,
> +			.sink_stream = 0,
> +			.source_pad = UNICAM_SD_PAD_SOURCE_IMAGE,
> +			.source_stream = 0,
> +			.flags = V4L2_SUBDEV_ROUTE_FL_ACTIVE,
> +		},
> +	};
> +
> +	struct v4l2_subdev_krouting routing = {
> +		.num_routes = ARRAY_SIZE(routes),
> +		.routes = routes,
> +	};
> +
> +	/* Initialize routing to single route to the fist source pad */
> +	return __unicam_subdev_set_routing(sd, state, &routing);
> +}
> +
> +static int unicam_subdev_enum_mbus_code(struct v4l2_subdev *sd,
> +					struct v4l2_subdev_state *state,
> +					struct v4l2_subdev_mbus_code_enum *code)
> +{
> +	u32 pad, stream;
> +	int ret = -EINVAL;
> +
> +	v4l2_subdev_lock_state(state);
> +
> +	ret = v4l2_subdev_routing_find_opposite_end(&state->routing, code->pad,
> +						    code->stream, &pad,
> +						    &stream);
> +	if (ret)
> +		goto out;
> +
> +	if (unicam_sd_pad_is_source(code->pad)) {
> +		/* No transcoding, source and sink codes must match. */
> +		struct v4l2_mbus_framefmt *fmt;
> +
> +		fmt = v4l2_state_get_stream_format(state, pad, stream);
> +		if (!fmt)
> +			goto out;
> +
> +		if (code->index > 0)
> +			goto out;
> +
> +		code->code = fmt->code;
> +	} else {
> +		const struct unicam_fmt *formats;
> +		unsigned int num_formats;
> +
> +		if (pad == UNICAM_SD_PAD_SOURCE_IMAGE) {
> +			formats = unicam_image_formats;
> +			num_formats = ARRAY_SIZE(unicam_image_formats);
> +		} else {
> +			formats = unicam_meta_formats;
> +			num_formats = ARRAY_SIZE(unicam_meta_formats);
> +		}
> +
> +		if (code->index >= num_formats)
> +			goto out;
> +
> +		code->code = formats[code->index].code;
> +	}
> +
> +out:
> +	v4l2_subdev_unlock_state(state);
> +
> +	return ret;
> +}
> +
> +static int unicam_sd_enable_streams(struct v4l2_subdev *sd, u32 pad,
> +				    u64 streams_mask)
> +{
> +	struct unicam_device *unicam = sd_to_unicam_device(sd);
> +	struct v4l2_subdev_state *state;
> +	u32 other_pad, other_stream;
> +	int ret;
> +
> +	if (WARN_ON(streams_mask != 1))
> +		return -EINVAL;
> +
> +	state = v4l2_subdev_lock_active_state(sd);
> +
> +	ret = v4l2_subdev_routing_find_opposite_end(&state->routing, pad, 0,
> +						    &other_pad, &other_stream);
> +
> +	v4l2_subdev_unlock_state(state);
> +
> +	if (ret)
> +		return ret;
> +
> +	unicam->sequence = 0;
> +
> +	dev_dbg(unicam->dev, "Running with %u data lanes\n",
> +		unicam->active_data_lanes);
> +
> +	ret = clk_set_min_rate(unicam->vpu_clock, UNICAM_MIN_VPU_CLOCK_RATE);
> +	if (ret) {
> +		dev_err(unicam->dev, "failed to set up VPU clock\n");
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(unicam->vpu_clock);
> +	if (ret) {
> +		dev_err(unicam->dev, "Failed to enable VPU clock: %d\n", ret);
> +		goto err_vpu_clock;
> +	}
> +
> +	ret = clk_set_rate(unicam->clock, 100 * 1000 * 1000);
> +	if (ret) {
> +		dev_err(unicam->dev, "failed to set up CSI clock\n");
> +		goto err_vpu_prepare;
> +	}
> +
> +	ret = clk_prepare_enable(unicam->clock);
> +	if (ret) {
> +		dev_err(unicam->dev, "Failed to enable CSI clock: %d\n", ret);
> +		goto err_vpu_prepare;
> +	}
> +
> +	ret = v4l2_subdev_call(unicam->sensor.subdev, video, enable_streams,
> +			       unicam->sensor.pad->index, BIT(other_stream));
> +
> +	if (ret && ret == -ENOIOCTLCMD)
> +		ret = v4l2_subdev_call(unicam->sensor.subdev, video, s_stream, 1);
> +
> +	if (ret) {
> +		dev_err(unicam->dev, "stream on failed in subdev\n");
> +		goto err_enable_stream;
> +	}
> +
> +	unicam->subdev.streaming = true;
> +
> +	return 0;
> +
> +err_enable_stream:
> +	clk_disable_unprepare(unicam->clock);
> +err_vpu_prepare:
> +	clk_disable_unprepare(unicam->vpu_clock);
> +err_vpu_clock:
> +	if (clk_set_min_rate(unicam->vpu_clock, 0))
> +		dev_err(unicam->dev, "failed to reset the VPU clock\n");
> +	return ret;
> +}
> +
> +static int unicam_sd_disable_streams(struct v4l2_subdev *sd, u32 pad,
> +				     u64 streams_mask)
> +{
> +	struct unicam_device *unicam = sd_to_unicam_device(sd);
> +	struct v4l2_subdev_state *state;
> +	u32 other_pad, other_stream;
> +	int ret;
> +
> +	if (WARN_ON(streams_mask != 1))
> +		return -EINVAL;
> +
> +	state = v4l2_subdev_lock_active_state(sd);
> +
> +	ret = v4l2_subdev_routing_find_opposite_end(&state->routing, pad, 0,
> +						    &other_pad, &other_stream);
> +
> +	v4l2_subdev_unlock_state(state);
> +
> +	if (ret) {
> +		dev_err(unicam->dev, "disable streams failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = v4l2_subdev_call(unicam->sensor.subdev, video, disable_streams,
> +			       unicam->sensor.pad->index, BIT(other_stream));
> +
> +	if (ret && ret == -ENOIOCTLCMD) {
> +		/* The sensor does not support disable streams. */
> +		if (unicam->node[UNICAM_IMAGE_NODE].streaming &&
> +		    other_pad == unicam->node[UNICAM_METADATA_NODE].pad.index) {
> +			/* We won't stop the sensor yet. */
> +			unicam->subdev.streaming = false;
> +			return 0;
> +		}
> +		/* There is no more the metadata node, we can stop. */
> +		ret = v4l2_subdev_call(unicam->sensor.subdev, video, s_stream, 0);
> +	}
> +
> +	clk_disable_unprepare(unicam->clock);
> +	if (clk_set_min_rate(unicam->vpu_clock, 0))
> +		dev_err(unicam->dev, "failed to reset the VPU clock\n");
> +	clk_disable_unprepare(unicam->vpu_clock);
> +
> +	unicam->subdev.streaming = false;
> +
> +	return 0;
> +}
> +
> +static int unicam_subdev_set_pad_format(struct v4l2_subdev *sd,
> +					struct v4l2_subdev_state *state,
> +					struct v4l2_subdev_format *format)
> +{
> +	struct unicam_device *unicam = sd_to_unicam_device(sd);
> +	struct v4l2_mbus_framefmt *sink_format, *source_format;
> +	const struct unicam_fmt *fmtinfo;
> +	int ret = 0;
> +
> +	if (format->which == V4L2_SUBDEV_FORMAT_ACTIVE && unicam->subdev.streaming)
> +		return -EBUSY;
> +
> +	/* No transcoding, source and sink formats must match. */
> +	if (unicam_sd_pad_is_source(format->pad))
> +		return v4l2_subdev_get_fmt(sd, state, format);
> +
> +	fmtinfo = unicam_find_format_by_code(format->format.code, format->pad);
> +	if (!fmtinfo)
> +		fmtinfo = &unicam_image_formats[0];
> +
> +	if (format->pad == UNICAM_SD_PAD_SOURCE_IMAGE) {
> +		format->format.width = clamp_t(unsigned int,
> +					       format->format.width,
> +					       UNICAM_MIN_WIDTH,
> +					       UNICAM_MAX_WIDTH);
> +		format->format.height = clamp_t(unsigned int,
> +						format->format.height,
> +						UNICAM_MIN_HEIGHT,
> +						UNICAM_MAX_HEIGHT);
> +	}
> +	format->format.field = V4L2_FIELD_NONE;
> +
> +	v4l2_subdev_lock_state(state);
> +
> +	sink_format = v4l2_state_get_stream_format(state, format->pad,
> +						   format->stream);
> +	source_format = v4l2_subdev_state_get_opposite_stream_format(state,
> +								     format->pad,
> +								     format->stream);
> +	if (!sink_format || !source_format) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	*sink_format = format->format;
> +	*source_format = format->format;
> +out:
> +	v4l2_subdev_unlock_state(state);
> +
> +	return ret;
> +}
> +
> +static int unicam_subdev_enum_frame_size(struct v4l2_subdev *sd,
> +					 struct v4l2_subdev_state *state,
> +					 struct v4l2_subdev_frame_size_enum *fse)
> +{
> +	const struct unicam_fmt *fmtinfo;
> +	u32 pad, stream;
> +	int ret = -EINVAL;
> +
> +	if (fse->index > 0)
> +		return ret;
> +
> +	v4l2_subdev_lock_state(state);
> +
> +	ret = v4l2_subdev_routing_find_opposite_end(&state->routing, fse->pad,
> +						    fse->stream, &pad,
> +						    &stream);
> +	if (ret)
> +		goto out;
> +
> +	if (unicam_sd_pad_is_source(fse->pad)) {
> +		/* No transcoding, source and sink formats must match. */
> +		struct v4l2_mbus_framefmt *fmt;
> +
> +		fmt = v4l2_state_get_stream_format(state, pad, stream);
> +		if (!fmt)
> +			goto out;
> +
> +		if (fse->code != fmt->code)
> +			goto out;
> +
> +		fse->min_width = fmt->width;
> +		fse->max_width = fmt->width;
> +		fse->min_height = fmt->height;
> +		fse->max_height = fmt->height;
> +	} else {
> +		fmtinfo = unicam_find_format_by_code(fse->code, pad);
> +		if (!fmtinfo)
> +			goto out;
> +
> +		fse->min_width = UNICAM_MIN_WIDTH;
> +		fse->max_width = UNICAM_MAX_WIDTH;
> +		fse->min_height = UNICAM_MIN_HEIGHT;
> +		fse->max_height = UNICAM_MAX_HEIGHT;
> +	}
> +
> +out:
> +	v4l2_subdev_unlock_state(state);
> +
> +	return ret;
> +}
> +
> +static const struct v4l2_subdev_video_ops unicam_subdev_video_ops = {
> +	.enable_streams	= unicam_sd_enable_streams,
> +	.disable_streams = unicam_sd_disable_streams,
> +};
> +
> +static const struct v4l2_subdev_pad_ops unicam_subdev_pad_ops = {
> +	.init_cfg		= unicam_subdev_init_cfg,
> +	.enum_mbus_code		= unicam_subdev_enum_mbus_code,
> +	.get_fmt		= v4l2_subdev_get_fmt,
> +	.set_fmt		= unicam_subdev_set_pad_format,
> +	.set_routing		= unicam_subdev_set_routing,
> +	.enum_frame_size	= unicam_subdev_enum_frame_size,
> +};
> +
> +static const struct v4l2_subdev_ops unicam_subdev_ops = {
> +	.video		= &unicam_subdev_video_ops,
> +	.pad		= &unicam_subdev_pad_ops,
> +};
> +
> +static const struct media_entity_operations unicam_subdev_media_ops = {
> +	.link_validate = v4l2_subdev_link_validate,
> +	.has_route = v4l2_subdev_has_route,
> +};
> +
> +static int unicam_init_and_register_subdev(struct unicam_device *unicam)
> +{
> +	struct v4l2_subdev *sd = &unicam->subdev.sd;
> +	int ret;
> +
> +	v4l2_subdev_init(sd, &unicam_subdev_ops);
> +	v4l2_set_subdevdata(sd, unicam);
> +	unicam->subdev.sd.entity.function = MEDIA_ENT_F_VID_IF_BRIDGE;
> +	unicam->subdev.sd.entity.ops = &unicam_subdev_media_ops;
> +	unicam->subdev.sd.dev = unicam->dev;
> +	unicam->subdev.sd.owner = THIS_MODULE;
> +	unicam->subdev.sd.flags = V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_MULTIPLEXED;
> +	snprintf(unicam->subdev.sd.name, sizeof(unicam->subdev.sd.name), "unicam-subdev");
> +
> +	unicam->subdev.pads[UNICAM_SD_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
> +
> +	unicam->subdev.pads[UNICAM_SD_PAD_SOURCE_IMAGE].flags = MEDIA_PAD_FL_SOURCE;
> +	unicam->subdev.pads[UNICAM_SD_PAD_SOURCE_METADATA].flags = MEDIA_PAD_FL_SOURCE;
> +
> +	ret = media_entity_pads_init(&sd->entity,
> +				     ARRAY_SIZE(unicam->subdev.pads), unicam->subdev.pads);
> +	if (ret) {
> +		dev_err(unicam->dev, "Could not init media entity");
> +		return ret;
> +	}
> +
> +	ret = v4l2_subdev_init_finalize(sd);
> +	if (ret) {
> +		dev_err(unicam->dev, "Could not finalize init for subdev");
> +		return ret;
> +	}
> +
> +	return v4l2_device_register_subdev(&unicam->v4l2_dev, sd);
> +}
> +
> +/* -----------------------------------------------------------------------------
> + * Videobuf2 Queue Operations
> + */
> +
> +static int unicam_queue_setup(struct vb2_queue *vq,
> +			      unsigned int *nbuffers,
> +			      unsigned int *nplanes,
> +			      unsigned int sizes[],
> +			      struct device *alloc_devs[])
> +{
> +	struct unicam_node *node = vb2_get_drv_priv(vq);
> +	struct unicam_device *unicam = node->dev;
> +	unsigned int size = is_image_node(node) ?
> +				node->v_fmt.fmt.pix.sizeimage :
> +				node->v_fmt.fmt.meta.buffersize;
> +
> +	if (vq->num_buffers + *nbuffers < 3)
> +		*nbuffers = 3 - vq->num_buffers;
> +
> +	if (*nplanes) {
> +		if (sizes[0] < size) {
> +			dev_dbg(unicam->dev, "sizes[0] %i < size %u\n", sizes[0],
> +				size);
> +			return -EINVAL;
> +		}
> +		size = sizes[0];
> +	}
> +
> +	*nplanes = 1;
> +	sizes[0] = size;
> +
> +	return 0;
> +}
> +
> +static int unicam_buffer_prepare(struct vb2_buffer *vb)
> +{
> +	struct unicam_node *node = vb2_get_drv_priv(vb->vb2_queue);
> +	struct unicam_device *unicam = node->dev;
> +	struct unicam_buffer *buf = to_unicam_buffer(vb);
> +	unsigned long size;
> +
> +	if (WARN_ON(!node->fmt))
> +		return -EINVAL;
> +
> +	size = is_image_node(node) ? node->v_fmt.fmt.pix.sizeimage :
> +				     node->v_fmt.fmt.meta.buffersize;
> +	if (vb2_plane_size(vb, 0) < size) {
> +		dev_dbg(unicam->dev, "data will not fit into plane (%lu < %lu)\n",
> +			vb2_plane_size(vb, 0), size);
> +		return -EINVAL;
> +	}
> +
> +	vb2_set_plane_payload(&buf->vb.vb2_buf, 0, size);
> +	return 0;
> +}
> +
> +static void unicam_buffer_queue(struct vb2_buffer *vb)
> +{
> +	struct unicam_node *node = vb2_get_drv_priv(vb->vb2_queue);
> +	struct unicam_buffer *buf = to_unicam_buffer(vb);
> +
> +	spin_lock_irq(&node->dma_queue_lock);
> +	list_add_tail(&buf->list, &node->dma_queue);
> +	spin_unlock_irq(&node->dma_queue_lock);
> +}
> +
> +static void unicam_return_buffers(struct unicam_node *node,
> +				  enum vb2_buffer_state state)
> +{
> +	struct unicam_buffer *buf, *tmp;
> +
> +	list_for_each_entry_safe(buf, tmp, &node->dma_queue, list) {
> +		list_del(&buf->list);
> +		vb2_buffer_done(&buf->vb.vb2_buf, state);
> +	}
> +
> +	if (node->cur_frm)
> +		vb2_buffer_done(&node->cur_frm->vb.vb2_buf,
> +				state);
> +	if (node->next_frm && node->cur_frm != node->next_frm)
> +		vb2_buffer_done(&node->next_frm->vb.vb2_buf,
> +				state);
> +
> +	node->cur_frm = NULL;
> +	node->next_frm = NULL;
> +}
> +
> +static int unicam_video_check_format(struct unicam_node *node)
> +{
> +	const struct v4l2_mbus_framefmt *format;
> +	struct unicam_device *unicam = node->dev;
> +	struct v4l2_subdev_state *state;
> +	int ret = 0;
> +
> +	state = v4l2_subdev_lock_active_state(&unicam->subdev.sd);
> +
> +	format = v4l2_state_get_stream_format(state, UNICAM_SD_PAD_SOURCE_IMAGE, 0);
> +	if (!format) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (node->fmt->code != format->code ||
> +	    node->v_fmt.fmt.pix.height != format->height ||
> +	    node->v_fmt.fmt.pix.width != format->width ||
> +	    node->v_fmt.fmt.pix.field != format->field) {
> +		dev_dbg(unicam->dev, "(%u x %u) %08x %s != (%u x %u) %08x %s\n",
> +			node->v_fmt.fmt.pix.width, node->v_fmt.fmt.pix.height,
> +			node->fmt->code,
> +			v4l2_field_names[node->v_fmt.fmt.pix.field],
> +			format->width, format->height, format->code,
> +			v4l2_field_names[format->field]);
> +		ret = -EPIPE;
> +		goto out;
> +	}
> +
> +out:
> +	v4l2_subdev_unlock_state(state);
> +
> +	return ret;
> +}
> +
> +static int unicam_start_streaming(struct vb2_queue *vq, unsigned int count)
> +{
> +	struct unicam_node *node = vb2_get_drv_priv(vq);
> +	struct unicam_device *unicam = node->dev;
> +	dma_addr_t buffer_addr[UNICAM_MAX_NODES] = { 0 };
> +	struct unicam_buffer *buf;
> +	struct v4l2_subdev_state *state;
> +	unsigned long flags;
> +	unsigned int i;
> +	int ret;
> +	u32 pad, stream;
> +	u32 remote_pad_index = is_image_node(node) ? UNICAM_SD_PAD_SOURCE_IMAGE
> +						   : UNICAM_SD_PAD_SOURCE_METADATA;
> +
> +	/* Look for the route for the given pad and stream. */
> +	state = v4l2_subdev_lock_active_state(&unicam->subdev.sd);
> +
> +	ret = v4l2_subdev_routing_find_opposite_end(&state->routing,
> +						    remote_pad_index, 0,
> +						    &pad, &stream);
> +	if (ret)
> +		goto err_streaming;
> +
> +	v4l2_subdev_unlock_state(state);
> +
> +	dev_dbg(unicam->dev, "Starting stream 0 on pad %d on subdev %s\n",
> +		remote_pad_index, unicam->subdev.sd.name);
> +
> +	/* The metadata node can't be started alone. */
> +	if (is_metadata_node(node)) {
> +		if (!unicam->node[UNICAM_IMAGE_NODE].streaming) {
> +			dev_err(unicam->dev,
> +				"Can't start metadata without image\n");
> +			return -EINVAL;
> +		}
> +		dev_dbg(unicam->dev, "starting metadata node\n");
> +
> +		spin_lock_irqsave(&node->dma_queue_lock, flags);
> +		buf = list_first_entry(&node->dma_queue,
> +				       struct unicam_buffer, list);
> +		dev_dbg(unicam->dev, "buffer %d: %p\n", i, buf);
> +		node->cur_frm = buf;
> +		node->next_frm = buf;
> +		list_del(&buf->list);
> +		spin_unlock_irqrestore(&node->dma_queue_lock, flags);
> +
> +		buffer_addr[UNICAM_METADATA_NODE] =
> +			vb2_dma_contig_plane_dma_addr(&buf->vb.vb2_buf, 0);
> +		dev_dbg(unicam->dev, "buffer %d addr: %lld\n", i, buffer_addr[i]);

i tried to compile the driver and get the following warning. I think the
easiest solution would be to drop this debug message.

In file included from ./include/linux/printk.h:555:0,

                 from ./include/linux/kernel.h:29,
                 from ./include/linux/clk.h:13,
                 from drivers/media/platform/bcm2835/bcm2835-unicam.c:47:
drivers/media/platform/bcm2835/bcm2835-unicam.c: In function
‘unicam_start_streaming’:
drivers/media/platform/bcm2835/bcm2835-unicam.c:1676:24: warning: format
‘%lld’ expects argument of type ‘long long int’, but argument 5 has type
‘dma_addr_t {aka unsigned int}’ [-Wformat=]
   dev_dbg(unicam->dev, "buffer %d addr: %lld\n", i, buffer_addr[i]);
                        ^
./include/linux/dynamic_debug.h:134:15: note: in definition of macro
‘__dynamic_func_call’
   func(&id, ##__VA_ARGS__);  \
               ^~~~~~~~~~~
./include/linux/dynamic_debug.h:166:2: note: in expansion of macro
‘_dynamic_func_call’
  _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
  ^~~~~~~~~~~~~~~~~~
./include/linux/dev_printk.h:155:2: note: in expansion of macro
‘dynamic_dev_dbg’
  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~
./include/linux/dev_printk.h:155:23: note: in expansion of macro ‘dev_fmt’
  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
                       ^~~~~~~
drivers/media/platform/bcm2835/bcm2835-unicam.c:1676:3: note: in
expansion of macro ‘dev_dbg’
   dev_dbg(unicam->dev, "buffer %d addr: %lld\n", i, buffer_addr[i]);
   ^~~~~~~
