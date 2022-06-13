Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD30549D69
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349053AbiFMTU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245565AbiFMTTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:19:54 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C16E3190F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:17:15 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 129so6125386pgc.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MjIxgZgAdZ27pbz58kc/VXLniYidA8CZXuhlH7oOL/o=;
        b=mqFYc6a/HcXcKs/9YanvoMICMIuT7Wl66V73KxHIDkb/h7yA9GpclZMyy4uZSy0Dki
         5q4Ah9RguD7PZQMp/OS5SHAr9joAtuStNRY9xXnuMXrRF/VuActBwoS0Tr2JOqvfmBgf
         ZkUxVNFkwLZk6Nb1woQicWhrdUGxoZQuLXqm9eoyycCwUUim3HUAozK4GpBl/e06eOl7
         D9oC5itpW1ZNf5BN7UjWqMKiBQqrx7Mrq8kSi0hS1KTwkZbhqz9epAbzvaDa97fLHh6h
         f1fvuzV/LqaDrsl2HwdPAUACKS/KdX7eWwpTal/N8Fkbs0oi8Tr/uEN54crpeU4fvQqW
         cLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MjIxgZgAdZ27pbz58kc/VXLniYidA8CZXuhlH7oOL/o=;
        b=A+OOw55snpWSUzDstdHWoBJ9L/vxuo9fheyh7Ex3F/pShynubCgeMp5+A4oyykonav
         cI9q06JOxcNEL6f8cyq6WumOcIGGH00+KWvPZRVo+nHm2fJd61K9eo6T7+/hCUpNUI0a
         VHfueU7iteSaJqthI/4JDOdn82Rjy+0VmBavE4OaZBKUthxZVsFTx1QmdWk5NlfvNkJa
         K6jgsW8D24nWwNub7XFFeHhEkR8cPl0iBcxwYD+eJgiMPk/RyYcMmyLXbpka5cHbq43q
         QYMpg7xicp88OzGfkSRr+D0SXE27DYw1AWIm1Ap91apc7jq7okSioPBRFqZePRcao8/2
         StXg==
X-Gm-Message-State: AOAM531ciigoG0RV4bR155FiUjCV/IkMxmwSi5ni5TigiMzInxUwcVgc
        Y1DQvULh2TCOJggzSvdgg90=
X-Google-Smtp-Source: AGRyM1sFz4TfdQtxwAKrfOcN0y+jj6y6S4D3hbgTh+fkCvSb5wOARWaEp6e3lePVhUAwkSr171ZtqQ==
X-Received: by 2002:a05:6a00:1a91:b0:51c:2ef4:fa1c with SMTP id e17-20020a056a001a9100b0051c2ef4fa1cmr553542pfv.75.1655140634869;
        Mon, 13 Jun 2022 10:17:14 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x15-20020a17090ab00f00b001e8875e3326sm7646802pjq.47.2022.06.13.10.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 10:17:14 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     tomer.yacoby@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, philippe.reynes@softathome.com,
        samyon.furman@broadcom.com, kursad.oney@broadcom.com,
        joel.peshkin@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] MAINTAINERS: Add BCM6756 to bcmbca arch entry
Date:   Mon, 13 Jun 2022 10:17:13 -0700
Message-Id: <20220613171713.241955-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220608175629.31538-4-william.zhang@broadcom.com>
References: <20220608175629.31538-1-william.zhang@broadcom.com> <20220608175629.31538-4-william.zhang@broadcom.com>
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

On Wed,  8 Jun 2022 10:56:29 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Add BCM6756 related files to BCMBCA ARCH maintainer list entry
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> 
> ---

Applied to https://github.com/Broadcom/stblinux/commits/maintainers/next, thanks!
--
Florian
