Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6464AC6DC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 18:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383807AbiBGRJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 12:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiBGRCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 12:02:41 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DD8C0401D3;
        Mon,  7 Feb 2022 09:02:40 -0800 (PST)
Received: from [192.168.0.175] ([151.127.53.97]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MGz9p-1nUc431LzX-00E51x; Mon, 07 Feb 2022 18:02:24 +0100
Message-ID: <eed40b17-9db7-ff97-822d-535eaeb73c65@green-communications.fr>
Date:   Mon, 7 Feb 2022 18:02:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] imx_thermal: Fix temperature retrieval after overheat
Content-Language: fr
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220207161829.4807-1-nicolas.cavallari@green-communications.fr>
In-Reply-To: <20220207161829.4807-1-nicolas.cavallari@green-communications.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:xG18oAhepxkOh6DIWJZDPXfxyrJin2ryIuz9EgSKE8xitq0xGB4
 m3KXUYXo7y7h+2T7QQH0qDtGihiuNeS8oyltyF769cqNY77cyfuR1sUhA2hzdFdcu1agIEd
 NGZd68CXgu6W5JN5X4SlsbFRp22q9eKAUjVdGaR5EY5KUhBiVzkRujSJlbtcKj3m5QgqsB0
 TMKhB233qM/Wfom0PyX7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zQ+TzyCXroE=:0ov39CnpbAPHJWiUTCYNMf
 1J3MQxS26dikqcsPQQTw+ygTGo8pI4d424GUONgKiXEprgN/hTge0LWaq7/P0OOC9cf+r/n9N
 efnTJefrV+iYqIyS45U464PblBEaiA4pfLEOkhaI9ryqWQVwovxgFqV3tYwb6hXkvMUVlQtXS
 onQNl4KV68n8zy9t9KrFyoP6WCtPFPAemMNEzY5Dz6ViDcFPrByEKRjuPt5rgliKjh5tB8oxq
 xsiJ4Fr5Ul83qmO6pp41NLH3Teycdq9LuzOMXBlNV7eGFOwtrRh4Vw5/17IgsjetXJwIfS+ko
 NfFBbPD6/j6hXG1i2cGdEEIV/3TGPTk6WOEdE0mIdHv922bbVhv6DYS3rBBFwGsyiyLMRfLvH
 nadq9luuqH7yfyZQP4e2jtaYLRmP80dtlsQIjCDVdJg2kvcaf0Mmr728eafxrUuZx0qPTcg+a
 HrEixYiy5fvmJ3AJc+AZTqL1YQkpsoT7lGYRDGPa6xU2Z9hPgYK/2GUP5ITgBx+5hzLNM2ytS
 s+9v0EE32OJC6VfphPhs+pj/lpJEJR2i7dzgzkpAbqAjmqbYWaeNLTPsKHmvixitQC2qMCCHt
 lhgnKWhm8jVWJgquRUUnVtPo6xEEW/Y/1vWZOE+q5yCfwGaw9jkYg/W6TKOibL/RZc0PV/5ku
 30vCeiEiBxbYvuM+SJcCFOSsS4qUZT+wLb3mj5J2RQGVFGN3PM2P2PJa5ADdLCvEsQ2lTOvsY
 ml18Lu2V94BRPRAPoEHoWlIvLkcGF7gw/5jw2A==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2022 17:18, Nicolas Cavallari wrote:
> When the CPU temperature is above the passive trip point, reading the
> temperature would fail forever with EAGAIN.  Fortunately, the thermal
> core would continue to assume that the system is overheating, so would
> put all passive cooling devices to the max.  Unfortunately, it does
> this forever, even if the temperature returns to normal.

Please drop this patch, apparently this was already fixed. Sorry for the 
noise.
