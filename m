Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB02655B443
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 00:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbiFZWFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 18:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiFZWFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 18:05:00 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DB72DC6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 15:04:59 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id lw20so15351753ejb.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 15:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=//8qIPvD9fx4vnZ4OSbBjfyuVaCRmOPsAXW5FiUJReQ=;
        b=jEraMw5PgXBCR7yp4ZGMgltpgL1elV+jITZQson/py3EPfMsd2X5TrA2QPgnJPv0rY
         f7IquTtHCzIXMebOMKGuiKQj6yVaycJgQf2drQ/kH5WKXm9J/a+pka+SF2oACxKQmRUs
         at+93CqKlgK+x2AYa2S/rEz+qkcK4CNRHCTcmRMbigk+VCQ3rBMvZYcRmON5DC8XYfEz
         7PoM+82USCDfRFaKPii1BdKHS+PYtlSFI3ta6fPvIViMpMQ4100hT6qoKVHBp3gHQKnE
         PAbmufiBBhuXvMCx0PZtSYKNFZ4o6ZEyI1kdu9p8k9PIzFLztZV/Upz0w6TbZKygjYq/
         31mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=//8qIPvD9fx4vnZ4OSbBjfyuVaCRmOPsAXW5FiUJReQ=;
        b=XJMb6tjxCzr6m2IZRnlx46ynqyrmXUC9CdUBONHWJqjB1TKyOLRPYH0zuzTOTNzGo6
         aWYh3eJA450RBshdejSbY+4ijG72aPUkQOoESsKJCX5Dp9c281i94YHq5sa+1NRURS+a
         Txh5f4ldTuu0WjjSE8rZ0lUyM65T6PBc+gjbz7PUvyHM/NjP1MF341bUpzVWP4ENwtj5
         EKLK3fRTSP3GLG5LaGl1a7JFP99r3UEb7LWEpy01JSptRagihg1I1zWmqFzLA1zfMeWi
         2svuCe+PIbgLISWnJS2ZQzFS846MzzQDzJCiOMR3RnFHEB+CuH6dWKv/mTnxWc2cxG5b
         4EMw==
X-Gm-Message-State: AJIora+hua2DnKVUHSdtWEc1uANr7AD7TTa6PVFubw3sggi+gUnuXn3r
        eVpNtmBR33ZB/+HXWIZOH6aaJ1rCnvpmybiDHJQ=
X-Google-Smtp-Source: AGRyM1sDEv/jauZf3Ot7PeMro4bmWPVUVrYNZA8AJKG4J8ZwjfHGooE37UqV9ZbFkwGQtylIuyjnSjTtF1XAsiOnc9I=
X-Received: by 2002:a17:906:3f51:b0:712:3945:8c0d with SMTP id
 f17-20020a1709063f5100b0071239458c0dmr9649843ejj.302.1656281098352; Sun, 26
 Jun 2022 15:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220621120015.113682-1-jiangjian@cdjrlc.com>
In-Reply-To: <20220621120015.113682-1-jiangjian@cdjrlc.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 Jun 2022 00:04:47 +0200
Message-ID: <CAFBinCANyt6+_wJ6dwr2xY53vn=hSU7ZQE_y79+MwYbTiUOzHA@mail.gmail.com>
Subject: Re: [PATCH] phy: dphy: drop unexpected word "the" in the comments
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com,
        kishon@ti.com, vkoul@kernel.org, jbrunet@baylibre.com,
        victor.liu@nxp.com, andrzej.hajda@intel.com,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Tue, Jun 21, 2022 at 2:01 PM Jiang Jian <jiangjian@cdjrlc.com> wrote:
>
> there is an unexpected word "the" in the comments that need to be dropped
>
> file: ./drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c
> line: 139
> * when in RxULPS check state, after the the logic enable the analog,
> changed to
> * when in RxULPS check state, after the logic enable the analog,
>
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
