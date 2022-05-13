Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E05C5260F7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379903AbiEML1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379837AbiEML1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:27:38 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55637252BB;
        Fri, 13 May 2022 04:27:36 -0700 (PDT)
Received: from mail-yb1-f182.google.com ([209.85.219.182]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MiuGK-1oJKZ11AhA-00evgc; Fri, 13 May 2022 13:27:35 +0200
Received: by mail-yb1-f182.google.com with SMTP id i11so14741178ybq.9;
        Fri, 13 May 2022 04:27:34 -0700 (PDT)
X-Gm-Message-State: AOAM533zP2idDhaZn+v94o2ilLZQvMZaCKPRivoYvDpjy2rK/RyPo6XF
        o1DqRuUBSj/+O4I4TFfrYBx3sGRqlrgSHcGyUWM=
X-Google-Smtp-Source: ABdhPJxXFB9FpCCJu9rHfB5HZ8J5KAizPMq2Oenp5z10//H3q8W/5et0hZRDpZgIV9WMtO0+mGArv752hS4eYW/sDn8=
X-Received: by 2002:a25:cbc9:0:b0:645:879a:cdd3 with SMTP id
 b192-20020a25cbc9000000b00645879acdd3mr4164061ybg.550.1652441253935; Fri, 13
 May 2022 04:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1652329411.git.qinjian@cqplus1.com> <36f0703f1b484563b678d8126aa3076683c4681a.1652329411.git.qinjian@cqplus1.com>
In-Reply-To: <36f0703f1b484563b678d8126aa3076683c4681a.1652329411.git.qinjian@cqplus1.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 13 May 2022 13:27:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2oSKbAraWUOQB32Tz_s4LUPzx8_VyiR5qoUw2d9GoXtw@mail.gmail.com>
Message-ID: <CAK8P3a2oSKbAraWUOQB32Tz_s4LUPzx8_VyiR5qoUw2d9GoXtw@mail.gmail.com>
Subject: Re: [PATCH v15 09/10] ARM: sp7021_defconfig: Add Sunplus SP7021 defconfig
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:K/M0jmKX+15vShxJP+2ZzKZVIS8MVshR5QF4MufJ9tO1QIpDj3A
 B3FfuC4ZlH/ToBPbqaqO2AyKBTTs1xd6XA2XJEuqvkvs0RbDfzqrAgerx9E6DEDT+Jzh1KL
 jxT2HqIQ9FNH4gDBGsX7Hx41D2lX4Pz8HgAoGjnhyWFhL//aT4Ucdgvlk3jlADpSJYb5yrm
 N3UvKkoxBIfQr7x/yEvOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vI/7Ek3EiTw=:R1wHfQ6H0CiOmVgwjLTsYB
 jzGrMaNL66+eqm6CdYma5rUBYlcIdu8ObsfJP2mbRBwJ8m1SMQ7myehBm/EZRBTiRgBzONsmx
 Ctw1RGE2H1tF4m8SVWUs1gnzfR3hExxMotGKbZeCIid38s4M061NLmtecRukdVWTOcWeLeK0Y
 IpGAN8KZMVnVfH0uCnPna7l2NFSNWSHnTPdGDKVtgFZaMeaMU+RxBOYcQHUP0wgOcb2gedowh
 7fVTznrqfqZiPMKCxMb+Mdp/fVb2U9r/IgXtZWh/3I24eIFwIiK4we6Eqe9nEfW3Vy+1q2EYB
 3nQa7Tder1DNju/dNhXyCR6fePo3qfKTwYsknS0dMh5mBb4i0KCuAGvfbsD+sbiP76Z4OxyRO
 TSdFmLxwzOD+Skc2fBwEeC6lfoQjJaIW3jMS3oSPgEgSOhI4w8jgDXoherZ6GLC/2lX+5V4qq
 lq42dxBynlpmdFl3wPkgHdI85yVowHHRTdJ66pSa4jOmVkG0cWRzAiWjuZyqi/3oVxSHPgQvx
 cvHD1sJxCnpJ9O9utTvWa6kPViCQvjtdvsG2/co6hjS0f08362Jq3MdKToo77GREW/gI2Dne3
 e/7qA8Zl/QzmOdHPS44RI54oxHzbnN+erkJfM5oz1ld95H1wfHoq01jdMv0MU9mZBGDlkQxa1
 xr8826lD5LIq9KVOmSdbC3ZokKjpmvJutc6QoUUiCxZLfXgusJqGwoAaqLU++rGEbrJo=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 8:31 AM Qin Jian <qinjian@cqplus1.com> wrote:
>
> Add generic Sunplus SP7021 based board defconfig
>
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
