Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B1A481BEC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 13:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbhL3MHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 07:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhL3MHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 07:07:41 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE6FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 04:07:41 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id o7so27485075ioo.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 04:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wkeQvjtAtW3zPrvbKD5gsvbJoOReOLmTGrd70LqAKzw=;
        b=VdWo5yj0VrN5lyuBJnO5hwWoz6zeRI2dNQEldR8vQAO3yTawVAJpuYXR24VLt1HL8Y
         rLTB5W+aRcsmOy0LG82HpqPY/cMachMQHGhLjslYWvWysWc8NTFr+QIT4Utdh7FG0YlO
         /2y0K4U5wHe6ga1R7wlampuvRbTOtUtHl82g4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wkeQvjtAtW3zPrvbKD5gsvbJoOReOLmTGrd70LqAKzw=;
        b=RoxcrqleSVfZP3KXzRprfWiDJdDVYfQoPJLu3RrtGVZYcP07xcAHoX4mmy+USsrPwV
         QlzgyBt0GB3GxnKaGUt6w0ukVhQxzGHemV2YR/eXXtl24BGtLu7u6AATBZDXh/TIuyo+
         HzBHPD+/1n5DwWQF4DUogKlovp6SsOEPN/JkuWRPvS8hYuz2R60qNwD2gkDBQVVgCmgw
         o1y/ZLvV6xECuPDr4Fhw/exKbIpp2D4Ql0c2RIU8P5VrtdQoJ2VV2Kpmq0vgLcXJ/MjH
         OPzL3tZxo3+Z0hO+ipMdrdmuxrzT78SOBoaVzF9G6vpk6C8AB9XR+c6ibnU1Lob+NMXD
         92yA==
X-Gm-Message-State: AOAM531JLXOS2rO3IxEJH1W+s4gwE/AsV89MnDwGGF7QtWkKOOhUgz2X
        R9uWOyv4eqs7gloXtKUqt2X2K/qNzQKFEkg2t3IeCQ==
X-Google-Smtp-Source: ABdhPJyxQpoNsYKYqHqrly02OkCz/px6gS2L/FF/QnOBWNjMgId2yRcRdUSpk3eZaJfK2WWQWixvy9CeMpsMtbGIvLY=
X-Received: by 2002:a6b:a10:: with SMTP id z16mr13081613ioi.204.1640866060817;
 Thu, 30 Dec 2021 04:07:40 -0800 (PST)
MIME-Version: 1.0
References: <20211108100608.22401-1-xiazhengqiao@huaqin.corp-partner.google.com>
 <CAJMQK-jTRt7OSkfCEmUBvC=2_dDo8vRC0awjJ4Jc+rzHFRUqzg@mail.gmail.com>
In-Reply-To: <CAJMQK-jTRt7OSkfCEmUBvC=2_dDo8vRC0awjJ4Jc+rzHFRUqzg@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 30 Dec 2021 20:07:14 +0800
Message-ID: <CAJMQK-ghm-QZfTUMLC_qt3+2o8n6VQ4yQaCfdTNwd3sOjMoBKw@mail.gmail.com>
Subject: Re: [RESEND] drm/panel: Add inx Himax8279d MIPI-DSI LCD panel driver
To:     xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 3:34 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> On Mon, Nov 8, 2021 at 10:06 AM xiazhengqiao
> <xiazhengqiao@huaqin.corp-partner.google.com> wrote:
> >
> > Add STARRY 2081101QFH032011-53G 10.1" WUXGA TFT LCD panel
> >
> > Signed-off-by: xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>

Can you also create this panel's binding document? thanks
