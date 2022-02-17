Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01AB94B9CC2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239037AbiBQKLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:11:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239035AbiBQKLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:11:53 -0500
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3DB2721
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 02:11:35 -0800 (PST)
Date:   Thu, 17 Feb 2022 10:11:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1645092693;
        bh=T6IpIe0qlak/CRlarOD0jKHaYw0xSiHQu/HYNWx/KyM=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=X+i20R5g6ti2hqmOoTzHcZag2oMG6wacA4IM9NAmsxM5gAbqBGJ0BrYEbJph2fNVv
         IP8F8DcPWOwL7kEgFlhn+Kd+zeXnREUhjPdBVoUn5j/9atEZSyStWGvQSY8HNGduWK
         zfTEw9aL7rd4112wrmpdNluANJjyHnbYKXP88qLlmsY2DUq2UQzQsZgPO4Zg61RbNe
         4cAOJFyW8sSm/47UyeQJ0qvFIlWqIwSIWzPP7cSukV9lAuQybM65SOFY8U+PR71Cq/
         tBuXy/ouPvAS2QntjYR6DKM8ciJEMErzpOV25DhhZEPD9cor+Pg+TJUzLjmIW8bXlZ
         ZNQ1fXHRqlaYQ==
To:     Geert Uytterhoeven <geert@linux-m68k.org>
From:   Simon Ser <contact@emersion.fr>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-fbdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH 8/8] drm/fourcc: Add DRM_FORMAT_D1
Message-ID: <DcHC6EkcAbkIdUGwoi3NJ9dU_zOwtndgZvp6ynoG05hPKPphZNEBAGWo25xgkxjjfmqzn2vBJcc3xGaFEMfWqY0jXNus1sWjmZSr9yzkcZE=@emersion.fr>
In-Reply-To: <20220215165226.2738568-9-geert@linux-m68k.org>
References: <20220215165226.2738568-1-geert@linux-m68k.org> <20220215165226.2738568-9-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday, February 15th, 2022 at 17:52, Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:

> Introduce a fourcc code for a single-channel frame buffer format with two
> darkness levels. This can be used for two-level dark-on-light displays.

The previous patches introduce C1 and R1. Do we really need D1? Can't
we just use R1 instead?

Simon
