Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362D5526E6E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiENDCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 23:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbiENDCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 23:02:38 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE56436EB84;
        Fri, 13 May 2022 20:00:29 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id e12so18219876ybc.11;
        Fri, 13 May 2022 20:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FO3MKohMHJssp0J8JWUbPK0Fl5XyZz02gMiMzQygvis=;
        b=uWu6IVPJxIvT7QawDvDfWDJjcIVjJOTt2GBJro/xXiaxEipNYdkYTXGEBpBbA/TCDP
         GbFBNjxvNuZKM3j7Ehh5KlkoG9pySj5fWqKJHWZdZcKIu0RlthMJjyD2IEWIIPHNpycF
         faeuPeTO2F/Zg8MVNuyER4+4Q6xG4Mw0vjPjgVWD57ZMXigHXLvM4F8WBbHCjQh+jamD
         3epPL65eGkqYgAlHRBU6tNCL0uveH2V2L2lUKUN5W42tcnwi3PfzkPYU/WfwOjWbdcVK
         PuiW+MmY7foOBovRDSV8ttHUYGYXAumo3kSn4TQIUg001ABQMwKBBOLQmP+jbi/qdXDm
         rXTA==
X-Gm-Message-State: AOAM532EHVnWrDjQ2SpIFJqjBrOdiM8qLnrLMfM5iQ9asNURm/AQ9UmN
        irSobFJnyICNsXnUgm7jdNXeIhounS5OE9vPa/wP8ZUG7yYRRg==
X-Google-Smtp-Source: ABdhPJy1mu/6onmTZFxZyJd3QjuRa7Rxpw0BlJHYjWO2RnIMvPyA0DX6qhW8PVdGsEuJeFxrzM1JKpi4/4jUbz5bzcM=
X-Received: by 2002:a5b:ac4:0:b0:64b:48de:269b with SMTP id
 a4-20020a5b0ac4000000b0064b48de269bmr8251361ybr.423.1652497225112; Fri, 13
 May 2022 20:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220513142355.250389-1-mailhol.vincent@wanadoo.fr>
 <20220513153606.302464-1-mailhol.vincent@wanadoo.fr> <20220513194003.10f72402.max@enpas.org>
In-Reply-To: <20220513194003.10f72402.max@enpas.org>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sat, 14 May 2022 12:00:13 +0900
Message-ID: <CAMZ6RqLqC8wDoyeJ0X=tWhUPUv3a0EN5CEZBJXRcbYKpT11Reg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] can: drop tx skb if the device is in listen only mode
To:     Max Staudt <max@enpas.org>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat. 14 May 2022 at 02:40, Max Staudt <max@enpas.org> wrote:
> From my view (I don't have the big picture here), this series looks good
> to me. Thanks!

Great! Can I add the tag below to the series?
Acked-by: Max Staudt <max@enpas.org>
(or any other based on your preference)

If this series gets pulled, you can remove the check from your driver.
