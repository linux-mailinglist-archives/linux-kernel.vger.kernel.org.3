Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F6449693C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 02:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbiAVBgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 20:36:36 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:36615 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiAVBgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 20:36:35 -0500
Received: from [192.168.1.107] ([37.4.249.169]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MUY5o-1mkeWP0bmi-00QRYE; Sat, 22 Jan 2022 02:36:09 +0100
Subject: Re: [PATCH v3 14/16] arm64: dts: fsd: Add initial device tree support
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org, linux-fsd@tesla.com,
        Arjun K V <arjun.kv@samsung.com>,
        Aswani Reddy <aswani.reddy@samsung.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        Sriranjani P <sriranjani.p@samsung.com>,
        Chandrasekar R <rcsekar@samsung.com>,
        Shashank Prashar <s.prashar@samsung.com>
References: <20220121172840.12121-1-alim.akhtar@samsung.com>
 <CGME20220121174117epcas5p4c1a7afa8b63ce4c55f05b6411d12fc09@epcas5p4.samsung.com>
 <20220121172840.12121-15-alim.akhtar@samsung.com>
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
Message-ID: <df109290-ceaa-97dd-3992-7dd60e515fe2@i2se.com>
Date:   Sat, 22 Jan 2022 02:36:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220121172840.12121-15-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:KmjB/oRF/iRBd8UrFlhNKFvzW6cZNkaNva127xjxQ+L4uK8vdeB
 Jx/00mvaJMzCL71kF8QI1C1JcAhOsPRLC+UvCRQankYFqsYzCLtvi/Ct9wsbY74DJ0Ul9NT
 nHi6vmd+IQd3Ms7ob5Kh6cW2mYAVPbzrLn/CE39I8k/AlL200IPY3GYAYzRvXRN7NogNDb1
 WhubH0PU9zgA5FAl437mw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+KGa/OyrfTg=:ZsLMVOVJ8h0NhAhDeXsGZn
 zpun82vPgNi72+IIUKWbhvJNWyl4I562olObUjruJsQL+9Dzl84hzbq+jK//S5IJcUiwN41B3
 RL8K7fADYJr0MnvlXSBdIEPiC5tEwT7kwlCx05TlUg5CgDPTQCGx6cKhiS8JFYCWbSOuoqYNx
 3N2XKB0tBZOwKh1mBrMX4IEO213AZ11N+ChX77ZpkeBoF386N36xIED07RE+1S48QPbLE4jdO
 hv2MTmhP33bM3Ygg/gMjDKU4qd/8vOHU7mr162SuSK/7IfEVsa601p3xpTpjbKhu4Uam1GK6a
 Z7TMidNWO7c3c9NWSGa0IKDgDx0y46WFcNeRle1XcCsWQ9otWNNRDWywGggGyvDGaMGX0ljfu
 cdj/EM/34MsAHrTsbHmdl3ZxCBkjmH8QCJiJtCADgX/lm+3vfGR2pZMs93Dji5gkJBwvM6Fgu
 0HUMO1ZROtHaQvvO2qKA86ABNNcqzngXqxuUXy+Q8P37VVEEYfCcpoRNUn5hSu3+eBmKm4UdP
 C0Y2hYbrc48vqKc4m/vpRPf7I/J602WUilOGutxSC76RwKUPR29qdWKbkn2BR23ROxeYSZTDj
 aGkP5OC9kWzjoSb8CckN6cKXhEac1+q5X/VVAZhqRaEohFGwupsp97d38kmNGbhpXes/GzA3B
 Iu8g8TxQc051v70h8vvFMO2qkD4fnkxab97vOBpGNg/vS92bL0dFnUK7Gb56t9fdzb/e9R1nu
 mdC04lEdivc7JyQ3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alim,

Am 21.01.22 um 18:28 schrieb Alim Akhtar:
> Add initial device tree support for "Full Self-Driving" (FSD) SoC
> This SoC contain three clusters of four cortex-a72 CPUs and various
> peripheral IPs.
>
> Cc: linux-fsd@tesla.com
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: Arjun K V <arjun.kv@samsung.com>
> Signed-off-by: Aswani Reddy <aswani.reddy@samsung.com>
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
> Signed-off-by: Chandrasekar R <rcsekar@samsung.com>
> Signed-off-by: Shashank Prashar <s.prashar@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  MAINTAINERS                           |   8 +
>  arch/arm64/Kconfig.platforms          |   6 +
>  arch/arm64/boot/dts/Makefile          |   1 +
>  arch/arm64/boot/dts/tesla/Makefile    |   3 +
>  arch/arm64/boot/dts/tesla/fsd-evb.dts |  39 ++
>  arch/arm64/boot/dts/tesla/fsd.dtsi    | 651 ++++++++++++++++++++++++++
>  6 files changed, 708 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/tesla/Makefile
>  create mode 100644 arch/arm64/boot/dts/tesla/fsd-evb.dts
>  create mode 100644 arch/arm64/boot/dts/tesla/fsd.dtsi
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 27730a5a6345..ed1c10c26e5b 100644

> diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
> new file mode 100644
> index 000000000000..9a2b88f58c13
> --- /dev/null
> +++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
> @@ -0,0 +1,651 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Tesla Full Self-Driving SoC device tree source
> + *
> + * Copyright (c) 2017-2022 Samsung Electronics Co., Ltd.
> + *		https://www.samsung.com
> + * Copyright (c) 2017-2022 Tesla, Inc.
> + *		https://www.tesla.com
> + */
> +
> +#include <dt-bindings/clock/fsd-clk.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
...
> +		pwm_1: pwm@14110000 {
> +			compatible = "samsung,exynos4210-pwm";
> +			reg = <0x0 0x14110000 0x0 0x100>;
> +			samsung,pwm-outputs = <0>, <1>, <2>, <3>;
> +			#pwm-cells = <3>;
> +			clocks = <&clock_peric PERIC_PWM1_IPCLKPORT_I_PCLK_S0>;
> +			clock-names = "timers";
> +			status = "disabled";
> +		};
> +
> +		hsi2c_0: hsi2c@14200000 {

since this is a i2c interface the node name should be changed to i2c:

hi2c_0: i2c@...

and the following ones.

> +			compatible = "samsung,exynos7-hsi2c";
> +			reg = <0x0 0x14200000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&hs_i2c0_bus>;
> +			clocks = <&clock_peric PERIC_PCLK_HSI2C0>;
> +			clock-names = "hsi2c";
> +			status = "disabled";
> +		};
> +
> +		hsi2c_1: hsi2c@14210000 {
> +			compatible = "samsung,exynos7-hsi2c";
> +			reg = <0x0 0x14210000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&hs_i2c1_bus>;
> +			clocks = <&clock_peric PERIC_PCLK_HSI2C1>;
> +			clock-names = "hsi2c";
> +			status = "disabled";
> +		};
> +
> +		hsi2c_2: hsi2c@14220000 {
> +			compatible = "samsung,exynos7-hsi2c";
> +			reg = <0x0 0x14220000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&hs_i2c2_bus>;
> +			clocks = <&clock_peric PERIC_PCLK_HSI2C2>;
> +			clock-names = "hsi2c";
> +			status = "disabled";
> +		};
> +
> +		hsi2c_3: hsi2c@14230000 {
> +			compatible = "samsung,exynos7-hsi2c";
> +			reg = <0x0 0x14230000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&hs_i2c3_bus>;
> +			clocks = <&clock_peric PERIC_PCLK_HSI2C3>;
> +			clock-names = "hsi2c";
> +			status = "disabled";
> +		};
> +
> +		hsi2c_4: hsi2c@14240000 {
> +			compatible = "samsung,exynos7-hsi2c";
> +			reg = <0x0 0x14240000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&hs_i2c4_bus>;
> +			clocks = <&clock_peric PERIC_PCLK_HSI2C4>;
> +			clock-names = "hsi2c";
> +			status = "disabled";
> +		};
> +
> +		hsi2c_5: hsi2c@14250000 {
> +			compatible = "samsung,exynos7-hsi2c";
> +			reg = <0x0 0x14250000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&hs_i2c5_bus>;
> +			clocks = <&clock_peric PERIC_PCLK_HSI2C5>;
> +			clock-names = "hsi2c";
> +			status = "disabled";
> +		};
> +
> +		hsi2c_6: hsi2c@14260000 {
> +			compatible = "samsung,exynos7-hsi2c";
> +			reg = <0x0 0x14260000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&hs_i2c6_bus>;
> +			clocks = <&clock_peric PERIC_PCLK_HSI2C6>;
> +			clock-names = "hsi2c";
> +			status = "disabled";
> +		};
> +
> +		hsi2c_7: hsi2c@14270000 {
> +			compatible = "samsung,exynos7-hsi2c";
> +			reg = <0x0 0x14270000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&hs_i2c7_bus>;
> +			clocks = <&clock_peric PERIC_PCLK_HSI2C7>;
> +			clock-names = "hsi2c";
> +			status = "disabled";
> +		};
> +	};
> +};
