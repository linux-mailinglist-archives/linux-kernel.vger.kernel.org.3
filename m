Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF255B02A1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiIGLQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiIGLQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:16:10 -0400
Received: from sonic308-11.consmr.mail.ne1.yahoo.com (sonic308-11.consmr.mail.ne1.yahoo.com [66.163.187.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336C685FA0
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 04:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1662549366; bh=D28LXyMm7oFN0CSwLIk1hUi8e910eghG1BhsXXW7YFw=; h=Date:From:Subject:To:Cc:In-Reply-To:References:From:Subject:Reply-To; b=oQ4Z3ElQ6sgUjf53I4GWTpTjEtFgaf9nswr8kUtK5k8kARRmoSnBGu2Fbw1Ll7RRmmmQDjYlWTG9cSqnS+qUiOkX0KoDZKAoaikmUmtAEx49UrRhHSta+xUf7rkqoyXb31PBbFRODWQX31/bj7V7z2SmAGqI+2W9jxM/P4lGYv8=
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1662549366; bh=XPNJtkWyVPHyo2TToBLjXBtiYCIBR5qNyDX0TQAz56r=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=MtMq0Kwtvy2StrIpxshT9P1wIMJBABIezVr+XsVTPVpStLmiX2Xc1OXZml3KSJAi89jHgUaNhBLFrst0ykeGJqz9cwBnLqHDjkYRTcyD79JNznG+xy4aAxTmzJh9qVUF7CLI0X+OQVwZHHXLXhocZ6np5A2yUrSVAmcf0/2vtTDKygLG19oE6yFmDPSfMzra1IfTj2ohCQA/oAyfai8NV0zpSbQwY0b1nYBggim+PmZeQq6CstyDJgKqcd1F4r0bGZNKObEcrnrLUUOoI/qz0cgCN7WB1Mx6HlVvchndhaBCHO9KK9byu+ASEGKhPBsEI0ZkmPpLPiObTXw/Q3fi5A==
X-YMail-OSG: vSXCuRQVM1n_azo_oFbV2qtWhyzYT_9Y1dHx2H6cgGipgEd3aOI.oNgYD8BVz9T
 aa3HY0V4CtC8gdCB5PIENKud4NPY5HtsTRnDLFJwcwSVASisFm3diFUvOP41QB85iFLdvjdxPrtm
 DqcOeq6Y1qE7KPWiL4DsxJr_K6q4KT4VJeSs3v7071fRXZbTe2HJB20qtbE_7o7uw0JGxydQDuI5
 HGg_KwtcQeBNNyGtzqggr8X2RR4Irft6iFEcW2sWe1_bV31eQcu5039_UDl4NqROZZuEpcazAmaT
 4ymPa9VUxW2qPh4lOd3A5vtttSkt9almxtPm.5top2YCQodP7PFXd8_ZEepw.g9f4hXCPTsCkOAa
 0_kw.u3sPFei_uKNszclM6ttlxsWEjkKm7G_M8_Q6xEmpoIFugWz74GWWxzWGPVspMaC6Ms9l3up
 MxWL7CMALUwsf8Oe_pxz6MLpDDp7MjpGNQBaGf0nvIJ61qeiOrWESyTSUrvtDvghmoGqWXwOPm24
 FXupgVdIO7vpMAdGbmZ1Kedn6Zwxc.tmlri7pLDHX6SwsGnPJxH6KvPvPFwGC3RkFV8vHcr49x3.
 gOW4l3UYrer0MKo138ZeSuiEaoYSqKER3wP586SXC9KfTSZMCZQP3K12YN1fX6ft1hI8nMgqSHvm
 GUKGwTHsiQU5vOdRizSxT8_4nrebAephSJRKRRdmpHhJ0UTqaw0gygHS726TUC35G_Lm.bgMWZXB
 1cTEgNrIMywJ5_K4KnDzzKb1BBA_jBBSbgAsGdWlFfCxMQiL0Nngkdx6X7KqBOYskgNe5zV8pLXP
 BJvcOSeGYyL7iG5m2nhIUTUKquAuapokw08xZfeTqbwcn_kmkHlLlCUQG6dW6Wmevv2C_qpv62rC
 p6VFaJpP7Yifarikyte2itVNS_kg12TyEmkIyro.fPHJEBykUdjAcfMq45jBYT_jxcuwnWveRdI8
 W0b1k7QIONsQ17opeVOqG1ad_Qtw1jvyW4_0TgQJfGJnPjznVrg_g93PeEFGfbRWBJcb0UxAmHTj
 HfwOeaRjva8DWC3e.SIx.HzfjgWGwGcgRACOVIeW6TnstSniS2TajBae7zWABEvsukLsAkgqT.X7
 OimjVqcVWFpF73YkXMtkN.z_zrwhEmoSHGA0QWTEskbKK5b5.suAiBQYrZR6FhDTeOembsh6G18I
 Bnpo55tRGNbp6LV7fa2Hs6NEU4IzcHBydQGLWmiBQ48WxSqjpSO2MQqBVnngts9Q.wwEqR9pFjY9
 .pQfkcKEJA1hJdi_dLEeHZb_cZA.yV0geonnrarBm35zsJGY.ThzSOh5lRD487qWwyDe4ra7nP14
 B9_rj7GgERjUTTmqJ3E2wqkkW5u1IaDnIVf1QjjlPgqnUp0lFiGRDI1jDQVbjdBgdEqecKbKNqaC
 MzRWtQO5rmikpBR27kebnPodDx1jNP4Vgu5EhwWl93EIqINbQZ2Jug2H2JF7n9ehHck5LBmNIscM
 XeLyjnZt9sEv7XINyi60Enn_R6eJmvDhwc6ZEtv3FOn6l_coDRFArfle8amPg0DKKcZRc7G3LXpD
 lt7hMLjLYBPRTPVns9Uf.KuJTdasIS0ONLMP8PcDkocwsDOERbJSsa6c.k4IqnTxmBxlghZUOlNA
 ssTMW8rlBo7ARxiPTf.pKL_.guU4y7WAt.Kb9YR9j3.RAKqnjqqFUX4iWC60F1W47qUBEg.6WZW9
 S9caoMKKMapEIPc_GQqmhtAGKR3apcfQ1o16ltWklW3IX8oi0ZrKqY8JE1XXP7_s_V2HWGgQGb5r
 WCD62buYBtI4sRINeL9WDYBQjg861dZnbcbCrrN5q6xl.KPgrK0r2EMuHLMnWWgQilqcHZ6Xgd.o
 mltaz88f.qPb3GnWlPxQuuRgGTJ4bct9HUIH6jKRiW42HSF2M5Ic1O.JPI_Oqabz0LfSYsPaWgoL
 UKv..tSH2QGqoguWMJLfezHvctQK5aiOmeTslB9Scs967nQjhQszn3veJoLaHNjAy2dGIyZnN7W.
 r.YQVYSX2CoHXfeAcpO.T.DCHm7FAXqSORnJTgVT_jwLnqHlxYhzE8S0PGwS.DXsgbMCHINL5qe4
 6ZaTG..4z0oEMxoe_4mWE52bzqpLYvFTkD_Jix.nnQuCU2rQbebNPoxB0PJKJLAa20O6jXvz4Mqb
 RaVBISKdJq008.MR_eppoac.AwPeIP9WdoZPesLZlxdVQyBJ1aUGUb07fjwxuVlr.LcTPrHfSVT2
 5DwWAZUGCKHxe
X-Sonic-MF: <pheonix.sja@att.net>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 Sep 2022 11:16:06 +0000
Received: by hermes--production-ne1-544744cc75-n6tzz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fbfc95aee6bd7e475c2a52445467b5fd;
          Wed, 07 Sep 2022 11:16:02 +0000 (UTC)
Date:   Wed, 07 Sep 2022 07:15:54 -0400
From:   Steven J Abner <pheonix.sja@att.net>
Subject: Re: thermal driver patch
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
Message-Id: <IA7UHR.UBUE22H3MNMY2@att.net>
In-Reply-To: <NZ5JHR.JGO592OT0D961@att.net>
References: <DL9RGR.8W3XFSCFFYXI2.ref@att.net> <DL9RGR.8W3XFSCFFYXI2@att.net>
        <0f961ea6-4948-0b7a-e01d-d62ca4065af8@infradead.org>
        <L9MDHR.JVBXTJ2L6TPP2@att.net>
        <cf3a3cbd-c189-a120-124f-98d6adac058d@infradead.org>
        <be354f9e-47c7-bd6e-c570-e7364858ced4@linaro.org>
        <NZ5JHR.JGO592OT0D961@att.net>
X-Mailer: geary/3.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Additional info:
After an automatic overnight suspend, from dmesg:
[23668.033055] thermal thermal_zone0: failed to read out thermal zone 
(-61)
[23668.033197] PM: suspend exit

So is it possible that driver iwlwifi is built with 'return -ENODEV;' 
into
its init/reset code?
Also this code from kernel 5.18.19 instead of 5.18.12 initial report 
messaging.

Steve


