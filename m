Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F192F52C403
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 22:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242201AbiERUCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 16:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242109AbiERUCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 16:02:31 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155411C9ACE
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:02:31 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id gg20so3097203pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 13:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bTN90yg6yRh0vT5LgU/Hr3c+UfioboEc8ZM+6x355qg=;
        b=G/burAQvpS112uruxKAELdd84EakGVK2K/DCMxgjvh5dgCZ1SjNQCwJvI9LRQ+hs7F
         YaTDE47SLLuomGyET6XTSf1TyfV9m+SwJTMIZl8EJhVf4UxWSE0sbq5G0NIM5Omr//Lb
         rjdUwZ30IwepYZad3qvte+YfCg1F7X+FvTCmyZbHIGiDgx6B1G3Pi5aFqTTTf9f2i9Ww
         JZU0lg3J3Yx+YrX298zvPXN5A1DLoDPnJ8qyM10pn5cP2OMhyjV8qa3/6Dw1XOqTCuyp
         tTRQB2AoHn0t4HQ+LDHrIWd1VfB0yceFra/6Rss1otXwWuJr3YcHY99/Yd79p13QjN51
         fyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bTN90yg6yRh0vT5LgU/Hr3c+UfioboEc8ZM+6x355qg=;
        b=HtxNps4jxjwARVJKIr13PXlrdMFukP81kddF0xeR3Z7UYaej8VV0Isqhr+fMh9zvVJ
         WCxUlcKfuvh8o/0a6ap2BrNyKSLdUsBbp2dvyeBkEuNAk964dNGAraMuEiVfIqnsi6IR
         RgvMVznychM/+otbpyCrJP/4ym9sg8GVgywBC3MT1v/05St9MkotDZDUO5bO1S0KYDrs
         +3uUTcD4Wo5bwtcKduX34CqIiXu0JxO7dXMdTZt3WqW85Xab9CUysBGomwRFwhSdV+k1
         YSWTy9IbZ0oet3d+tsCcayVDrkopsDydOR4zVWy670ASU606xPxadVN4l3gawqUjR3Ur
         0vIw==
X-Gm-Message-State: AOAM532rviFtS9KxD4idJXZE0hbx37QNKozhf4dmZJRBkRUEOCSvaUV3
        2TlEaQSkH2seVj4QFeN31Cc=
X-Google-Smtp-Source: ABdhPJxhr0rjXIXUkmgu/ytrRCtx9/CfsRix9PSECNjGFFHiVTw3ccBttC3mR+eYtPbRcEFMJNpqmQ==
X-Received: by 2002:a17:902:ccc1:b0:15a:24df:a7cc with SMTP id z1-20020a170902ccc100b0015a24dfa7ccmr1240891ple.42.1652904150541;
        Wed, 18 May 2022 13:02:30 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l184-20020a6388c1000000b003f27adead72sm1918548pgd.90.2022.05.18.13.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 13:02:30 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Anand Gore <anand.gore@broadcom.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        florian.fainelli@broadcom.com, kursad.oney@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] MAINTAINERS: add bcm63178 to bcmbca arch entry
Date:   Wed, 18 May 2022 13:02:28 -0700
Message-Id: <20220518200228.323436-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516103801.3.I8e64917a681a6eb635693e212e7d8acbddefcc7a@changeid>
References: <20220516173808.1391482-1-anand.gore@broadcom.com> <20220516103801.3.I8e64917a681a6eb635693e212e7d8acbddefcc7a@changeid>
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

On Mon, 16 May 2022 10:38:08 -0700, Anand Gore <anand.gore@broadcom.com> wrote:
> Add bcm63178 related files to BCMBCA ARCH maintainer list entry
> 
> Signed-off-by: Anand Gore <anand.gore@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/maintainers/next, thanks!
--
Florian
