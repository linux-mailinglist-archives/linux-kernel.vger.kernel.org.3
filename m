Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40940597EEC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 09:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243768AbiHRHFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 03:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243762AbiHRHFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 03:05:11 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3F586FFB;
        Thu, 18 Aug 2022 00:05:09 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id s129so621091vsb.11;
        Thu, 18 Aug 2022 00:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=AjriiNks9RHRoCBN7ZUJ6jtj7TS2aTJuQAkCqUAkW5Y=;
        b=OveoAobst4dQgzVcV+b2hUYKC6v8Bu1nEkiCbdf5FW37KCqyv7XSu0oLbibqxi+P2I
         JSVBCOQ3WWAceNJsnm/Zhwd/xIVJAd+M9IrJ48Cb52rDvVi0eb52FvtUIj4/+Xld+MPr
         qBgTd99HbHfHUA9Hrg6Bh0CZOOEy1ozS3724GEhA0ki99vdSYKASgLbgNpxYHBKne+LL
         aRs/q4iSpgR72FZYFsqU5vun7DfI3ru4dlg3Fw7EVEbdIxWzq0yPgfmP/e4HSx8qgOT7
         gug5se3NsFe2RVzQU5JzrnQoTlZYnNemIwDMFA1gss78x4jizikMd+gDBllm0l6pEV0E
         CGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=AjriiNks9RHRoCBN7ZUJ6jtj7TS2aTJuQAkCqUAkW5Y=;
        b=oTUW4mMcGfDZ5mSL+Fb6MhtyJaPQJzlKy21vdC/V1dyTiDNJPXv9W1A73hibRlzdbY
         sFZUehRT94Z6VAn09oQxKCBAHjEO104i39W3Cv+b7eFxzHEhl7sFDVI0JUNYIVaTDrEq
         JA4b04eM7vG+FMgvmPiYUABBKVYUMjiDzyRhIlYywLVlSPWKxhflcfu9Fl4Y0gc90Fb4
         bJrrh8jAoFAyswWEm2u4bK47/LnL2+TQTCdLsAz00Qz3irM7qu5u3+dNpRtgAT/TCrD6
         majlsIv9uyK4OCUVwXsi3gQE9ay5yR6QrBARdme01YfgTIThkTrabdFFOdoqf4+/L9Ox
         nmgw==
X-Gm-Message-State: ACgBeo2v0L0hI9O7g/AxXyMIMuG9PW8Z+SG/xW5pFSGJVdPzjCLFV+gU
        OXqCohr2WCmxADUTCe9cJD0rqRBR+LGqAxBSnV8=
X-Google-Smtp-Source: AA6agR4SXRtluW797qZbkdraB+aWdq4UMbY/7gnYhTK9K3tJvmg7YIGhYwFKeNd/Azfqw6j+kBLhK3/iwIRasxLKc3A=
X-Received: by 2002:a05:6102:2139:b0:38d:1e1f:7230 with SMTP id
 f25-20020a056102213900b0038d1e1f7230mr510987vsg.47.1660806309000; Thu, 18 Aug
 2022 00:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <1660787634-28550-1-git-send-email-shengjiu.wang@nxp.com> <1660787634-28550-2-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1660787634-28550-2-git-send-email-shengjiu.wang@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 18 Aug 2022 10:04:55 +0300
Message-ID: <CAEnQRZB19WxVYxabOdN3ee+pp9cbwgY7p=k+6P1BqONCEJjjnQ@mail.gmail.com>
Subject: Re: [Sound-open-firmware] [RESEND PATCH v2 2/2] ASoC: SOF: imx: Add
 i.MX8ULP HW support
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        shengjiu.wang@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        sound-open-firmware@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 5:12 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> From: Zhang Peng <peng.zhang_8@nxp.com>
>
> This adds skeleton support for the audio DSP hardware found on
> NXP i.MX8ULP platform.
>
> On i.MX8ULP resources (clocks, power, etc) are managed by the
> System Integration Module in LPAV domain and XRDC which is handled
> by arm trusted firmware.
>
> Signed-off-by: Zhang Peng <peng.zhang_8@nxp.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
