Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088A65933A3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbiHOQ5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiHOQ4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:56:53 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5E824F38
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 09:56:51 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id l8so5751809qvr.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 09:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ql8eeFP8VldCKGEGHRH6x8hl9x7HohTe/ybs1aa7v+I=;
        b=INnF345wX0o+zSm8YBZCWT8L8ahUyNBggVSSIB2d/x1jpUa6D7Cpg3r+wBRRg7lKn5
         OJXtvG3PkEdf6QIkbqD4CY3na6P9KXxrL6NlFTa6w62O3cqNV4/Jqt2Nb1zPFzGknVrP
         GINHop3s/M/DnixIZvJ417Jyyfqk02v4cLgaYY/BBecuyr//SH2BtP8AJh5oo/oSg01t
         lB+fFTUt62dfPlLHwCIdYdT6zivKWSQoW4HK+jx0+T6SPZlCXHeGlGSTgDl7OfNEmGbH
         efCx3cADcnyyJDXeoF9hmIOrWlkjH8rxIrVxgtY5q4YqzdF86mIubrR2IJM78ZOr3EqT
         8SFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ql8eeFP8VldCKGEGHRH6x8hl9x7HohTe/ybs1aa7v+I=;
        b=7MzRJkRVJDc9ay96J2WjEqDHnuLQ32VdbQb8xsiW1+QNGhQ7ljxVsoXSARgSoHpSE4
         BIGzvxS0P50sDD9IefrgUsxXOv/gNHaqJTfRzqyH0QX6XN3pXZwdGjjXJCwcrdD1Ha1V
         eGlHyl3pXzXdpEvhgjsChcjWKxDARF/vZkzIaTVfgkdM40TZbfodJ5zxZazeWF3UXT03
         b8/MXe5158jTSxzdQjm1nvdufUM+tK6f5zoB8rvLGwmRHrRv/JVD0sntOJQgzwawI/hq
         dvJ1Z0RqnK0zD+6BIj/KRspCWy//xoNmqQn51SbbBhWtCTM6eZ3Lp239vuPXDJAFhFOg
         fJjg==
X-Gm-Message-State: ACgBeo1w9fHK5kJqwbfkOO6riKwGwQeE2NcZyYFNrxeWFQ75SHt16cLO
        9iUtXtxvbpnqQUXqbPlGpNsG9grnVyI=
X-Google-Smtp-Source: AA6agR7tsy7lG53b/tUC0yQqtO+C2Zy0eqhvAPIl2S7P8YtS1aym8ssSZDcuqY3luza9u/fLX3aU+g==
X-Received: by 2002:ad4:5ded:0:b0:478:f7a1:bc4e with SMTP id jn13-20020ad45ded000000b00478f7a1bc4emr14729764qvb.54.1660582610725;
        Mon, 15 Aug 2022 09:56:50 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id ey23-20020a05622a4c1700b003431446588fsm8729026qtb.5.2022.08.15.09.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 09:56:50 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        krzysztof.kozlowski@linaro.org, rafal@milecki.pl,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 8/9] MAINTAINERS: Add BCM4908 maintainer to BCMBCA entry
Date:   Mon, 15 Aug 2022 09:56:48 -0700
Message-Id: <20220815165648.2502083-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803175455.47638-9-william.zhang@broadcom.com>
References: <20220803175455.47638-1-william.zhang@broadcom.com> <20220803175455.47638-9-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  3 Aug 2022 10:54:54 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Since BCM4908 SoC support is merged into ARCH_BCMBCA, add BCM4908
> maintainer Rafal to bcmbca maintainer list.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/maintainers/next, thanks!
--
Florian
