Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE724F1E65
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378333AbiDDV6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378944AbiDDQGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:06:17 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C6D13F42
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:04:18 -0700 (PDT)
Date:   Mon, 04 Apr 2022 16:04:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1649088253;
        bh=MNQPsaRTdNuR6i4bvVbc9kz9CWRg9mt2GHJ95iZJ/wA=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=wQnCPUjpj6cP3utbMDMHFF7wWTlKWwC6I0AI/cjjoQMicMl9JPEZk/nvRXACkrvqe
         lyHsbub9wAoJhDJRRnuBaI8H/cA8L+LYH6AV2KCkWFXHPfxeOu9DT385NJmrPcfuKB
         KSDkGE2hoic9aV+z6T5am+mq+bWdioToldhcyYYnA45OW6e0G+/bpS9yfiY8twHoBR
         nx6fjwdfNWNDxLk/KxlC/J2bBzwyVMBNvnygvg29cT2CCZvLW0KRpKsMdp8CmaZUod
         b3f4Wkwh5VoQJixn6JdEXLOlGYU9vF8T37VcVaMyr7/RH5zX/WO5iuvihP0TruEGlA
         nApKLK1Jgad2g==
To:     Randy Dunlap <rdunlap@infradead.org>
From:   Simon Ser <contact@emersion.fr>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] drm/format_helper: fix a kernel-doc typo
Message-ID: <ttcrpLw9HkdhAH5SkXylXDBi9SBf7LWgOeW09ZvTF4U4_zKJAOXBQZlFxfw6NKY0Hip6dXBFape6zkX09cstuOno72c-c00wmZ_VbNDg6xs=@emersion.fr>
In-Reply-To: <20220403232902.1753-1-rdunlap@infradead.org>
References: <20220403232902.1753-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SCC_BODY_URI_ONLY,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both doc patches pushed, thanks. I had to manually edit them because they
wouldn't apply cleanly. Next time, please use git-send-email (see
https://git-send-email.io/ for setup instructions).
