Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D7F4A8F48
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 21:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234739AbiBCUor convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Feb 2022 15:44:47 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:35727 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiBCUmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 15:42:42 -0500
Received: from [192.168.1.107] ([37.4.249.169]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N6Kl7-1m9x1K1XUv-016jtC; Thu, 03 Feb 2022 21:42:23 +0100
Subject: Re: [RFC PATCH v4 05/12] media: bcm2835-unicam: Add support for
 CCP2/CSI2 camera interface
To:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
References: <20220203175009.558868-1-jeanmichel.hautbois@ideasonboard.com>
 <20220203175009.558868-6-jeanmichel.hautbois@ideasonboard.com>
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
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        devicetree@vger.kernel.org, kernel-list@raspberrypi.com,
        laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        LMML <linux-media@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org, lukasz@jany.st,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        naush@raspberrypi.com, Rob Herring <robh@kernel.org>,
        tomi.valkeinen@ideasonboard.com,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com
Message-ID: <eeac52c6-dc48-bf65-9844-a3d5ffb70215@i2se.com>
Date:   Thu, 3 Feb 2022 21:42:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220203175009.558868-6-jeanmichel.hautbois@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Provags-ID: V03:K1:akZhkSnEhZvF6xTDF5MELWFP5PEyQnXRhFg2k8yQFcjIBLpfAcm
 9xhFqsB7kJbbPMwy1p98SJ1qgmflkHCI/snYPWUKbqGOseMUHr6sBVNTOWiU1QIdaPNbH7o
 NYPPCYVX2dRk/52mHH47Xmjktz6nOtCe/C0npiZ9w0NucD2GEKm7Upv5DRkgV3PGBU65OzF
 t6wz5OlLmzPMzER5rFz7Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cwYnIT5/pY8=:pPbiuZQBhMYpf7QVFPzME1
 D/A2KfG+oRO8OkR02/YaGcnsOw7rMgkuvgkzmcqMVMJ0B4Rt6qXEkT722cbnmMufcb6GGEWSH
 o+OSf8tkEOnctQ8vGX0hhUpG49UkDsH2Dus0u8wavFnlkPlrkv6QssGAi3h/x5FkGvggPyDEb
 4QjTPi23q0NiXd+it9LLHW/qX6RRWObO3uftNQRVhRWYIXugzxzJBUxaMW6/ANhclb++vnBS8
 /Whx3SobP0JSxUj7KfpCyY1KLutsVuKs0MzRdjENcz4UP3i18PXiUP3PNvt0D6xGGRmSlO6m9
 NW5SBfX+85T0uxjZI/JP/lIY0RT6rSZQop3zN4pBQb8cC+P0JHppLd6P0i5Z8beDkTtOE8R9S
 twWNVob7Q6JVXqyVQuFoDWOw+qkETLz9GDgwd/xJobmBT3nPiBokWFVG9bDafExWEvdQhFr2i
 8bdXNcbccoxI0me7TzQsyISYl/lQwOZ5ox4iV9U2XZFXyCg28yUrEb9xunkCJDhdI3ilmTnkc
 a7ymx2Y3wAEyD2Y1UWMMRp1/+y6oFSgkuAYsEYhPVEvIjdIMGnfVhuhGVmyGseXSyxkEFilu0
 P7HpNiHFZS3TFvP3+BiDh2b6xSuHwW+0SoHc3S/XvSfxwU/lZqbw/bEUrcsYB1yu7a8dyBihK
 loUO7JS6kMyjG4GGnQAUzm5bOufK5HIpvT9VikYUikKA4wiyvaNtozxHyfbhfEKsdb3lieIW3
 LLOOqsIvhz3C/mpG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Michel,

Am 03.02.22 um 18:50 schrieb Jean-Michel Hautbois:
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
>  MAINTAINERS                                   |    1 +
>  drivers/media/platform/Kconfig                |    1 +
>  drivers/media/platform/Makefile               |    2 +
>  drivers/media/platform/bcm2835/Kconfig        |   21 +
>  drivers/media/platform/bcm2835/Makefile       |    3 +
>  .../media/platform/bcm2835/bcm2835-unicam.c   | 2586 +++++++++++++++++
>  .../media/platform/bcm2835/vc4-regs-unicam.h  |  253 ++
>  7 files changed, 2867 insertions(+)
>  create mode 100644 drivers/media/platform/bcm2835/Kconfig
>  create mode 100644 drivers/media/platform/bcm2835/Makefile
>  create mode 100644 drivers/media/platform/bcm2835/bcm2835-unicam.c
>  create mode 100644 drivers/media/platform/bcm2835/vc4-regs-unicam.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 740cf86c56dc..ef2cdb37e06f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3676,6 +3676,7 @@ L:	linux-media@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/media/brcm,bcm2835-unicam.yaml
>  F:	arch/arm/boot/dts/bcm283x*
> +F:	drivers/media/platform/bcm2835/
>  
>  BROADCOM BCM47XX MIPS ARCHITECTURE
>  M:	Hauke Mehrtens <hauke@hauke-m.de>
Please move this change to the "single" MAINTAINER patch
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
> diff --git a/drivers/media/platform/bcm2835/bcm2835-unicam.c b/drivers/media/platform/bcm2835/bcm2835-unicam.c
> new file mode 100644
> index 000000000000..95e12fdb90f5
> --- /dev/null
> +++ b/drivers/media/platform/bcm2835/bcm2835-unicam.c
> @@ -0,0 +1,2586 @@
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
> +#include "vc4-regs-unicam.h"
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
> +#define UNICAM_EMBEDDED_SIZE	16384
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
Please remove those unnecessary comments ...
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
> +static const struct unicam_fmt formats[] = {
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
> +	/*
> +	 * 16 bit Bayer formats could be supported, but there is no CSI2
> +	 * data_type defined for raw 16, and no sensors that produce it at
> +	 * present.
> +	 */
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
> +	/* Embedded data format */
> +	{
> +		.fourcc		= V4L2_META_FMT_8,
> +		.code		= MEDIA_BUS_FMT_METADATA_8,
> +		.depth		= 8,
> +		.metadata_fmt	= 1,
> +	}
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
> +	unsigned int node_id;
> +	/* Source pad id on the subdev for this node */
> +	unsigned int src_pad_id;
> +	/* Pointer pointing to current v4l2_buffer */
> +	struct unicam_buffer *cur_frm;
> +	/* Pointer pointing to next v4l2_buffer */
> +	struct unicam_buffer *next_frm;
> +	/* video capture */
> +	const struct unicam_fmt *fmt;
> +	/* Used to store current pixel format */
> +	struct v4l2_format v_fmt;
> +	/* Used to store current mbus frame format */
> +	struct v4l2_mbus_framefmt m_fmt;
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
> +	struct media_pipeline pipe;
> +	/*
> +	 * Dummy buffer intended to be used by unicam
> +	 * if we have no other queued buffers to swap to.
> +	 */
> +	void *dummy_buf_cpu_addr;
> +	dma_addr_t dummy_buf_dma_addr;
> +
> +	/* Stream connected */
> +	u32 stream;
> +};
> +
> +struct unicam_device {
> +	struct kref kref;
> +
> +	/* V4l2 specific parameters */
> +	struct v4l2_async_subdev asd;
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
> +	struct device *pdev;
> +	/* subdevice async Notifier */
> +	struct v4l2_async_notifier notifier;
> +	unsigned int sequence;
> +
> +	/* ptr to  sub device */
> +	struct v4l2_subdev *sensor;
> +
> +	/* Internal subdev */
> +	struct {
> +		struct v4l2_subdev sd;
> +		struct media_pad pads[UNICAM_SD_NUM_PADS];
> +		bool streaming;
> +	} subdev;
> +
> +	/* Remote pad pointer */
> +	struct media_pad *remote_pad;
> +
> +	enum v4l2_mbus_type bus_type;
> +	/*
> +	 * Stores bus.mipi_csi2.flags for CSI2 sensors, or
> +	 * bus.mipi_csi1.strobe for CCP2.
> +	 */
> +	unsigned int bus_flags;
> +	unsigned int max_data_lanes;
> +	unsigned int active_data_lanes;
> +	bool sensor_embedded_data;
> +
> +	struct unicam_node node[UNICAM_MAX_NODES];
> +};
> +
> +static inline struct unicam_device *
> +v4l2_device_to_unicam_device(struct v4l2_device *v4l2_dev)
> +{
> +	return container_of(v4l2_dev, struct unicam_device, v4l2_dev);
> +}
> +
> +static inline struct unicam_device *
> +sd_to_unicam_device(struct v4l2_subdev *sd)
> +{
> +	return container_of(sd, struct unicam_device, subdev.sd);
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
> +static inline void unicam_clk_write(struct unicam_device *dev, u32 val)
> +{
> +	writel(val | 0x5a000000, dev->clk_gate_base);

This magic number has a special meaning for the clock manager. Look at
drivers/clk/bcm/clk-bcm2835.c. Either we use the define CM_PASSWORD or
add at least a comment.

...

> +
> +static int of_unicam_connect_subdevs(struct unicam_device *dev)
> +{
> +	struct device *pdev = dev->pdev;
> +	struct v4l2_fwnode_endpoint ep = { };
> +	struct fwnode_handle *ep_handle;
> +	struct v4l2_async_subdev *asd;
> +	unsigned int lane;
> +	int ret = -EINVAL;
> +
> +	if (of_property_read_u32(pdev->of_node, "num-data-lanes",
After adding the vendor prefix in the binding, i think this should be
updated?
> +				 &dev->max_data_lanes) < 0) {
> +		dev_err(dev->v4l2_dev.dev, "number of data lanes not set\n");
> +		return -EINVAL;
> +	}
> +
...
> +
> +static int unicam_probe(struct platform_device *pdev)
> +{
> +	struct unicam_device *unicam;
> +	int ret = 0;
> +
> +	unicam = kzalloc(sizeof(*unicam), GFP_KERNEL);
> +	if (!unicam)
> +		return -ENOMEM;
> +
> +	kref_init(&unicam->kref);
> +	unicam->pdev = &pdev->dev;
> +
> +	unicam->base = devm_platform_ioremap_resource(pdev, 0);

After adding the reg-names to the binding the driver can access the
register by name:

devm_platform_ioremap_resource_byname()

This is easier to read/understand.

Best regards


