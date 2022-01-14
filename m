Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DD148EED4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 17:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243650AbiANQ6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 11:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiANQ6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 11:58:09 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9F6C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 08:58:09 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id h15so6915140qtx.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 08:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3/LknUee5tShvPQdGCDJMgZycBj7j7tFq0oVBnp2e2k=;
        b=iVbeHVWMHHQPD1rqqEEZ8DrfcGbToE5o1zbVM35kRg/Odick5qpphoDqLNEV9QsqWM
         MdJuBLZpxmVZUGKZ/U+RT1Dz9gF35kE9KGSv9DtH01kx/MVKsj0th6OCGg44bRFur3do
         owooPCV25uNhuTReUXOtvctS+yL0qqIjAuYoQWs4Z/fXicEeTIVphCSjEonP+DaPuugh
         iRERJ3q7mKRJ4tiaWnKlZ7vUZPO83bjO7ijrkCdhr1Td21bxGEASeVEyhxiK2/fZmGpC
         HdiecBrry7MYtklo3Uo9OBTlnElF/8Q4Pd8a6vxoN6d9aP8OLwdBZQ6B3ug4ThoM3j8K
         v2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3/LknUee5tShvPQdGCDJMgZycBj7j7tFq0oVBnp2e2k=;
        b=khlSwPhwuZrx5QYv9Ewy/+jt6r5VwtlBPwUaODjlKOMrtk4wS8bs8jLBDjWcjzlU2q
         ALG7voBUa+8jgnQgNEbZpdbQYFqee3wimZ2Yg0xuj47ufp+mxEk7KmY3WM4nZSmmg2Cc
         t+QCzLFl9CgfGUM4X/5p/vmb0JEQzbv/QYAnHnmg4OxXJgT6TIeXvI5uEqRbj5QLnTD0
         1dsCxDO6xm7jWEz/3fwIfF3x2rh7aSnceWvY02NPSqlsRgb6JidJMfnFwPJU5XBN33GA
         r+x8608jzbROaFPEvcIYU4G1bRsc+PtJlylXbi5au6JPmTVRhPu/DWpoPUHs4uP9XP6d
         z7Og==
X-Gm-Message-State: AOAM530jqXFmitu9cTcIGNlRKWp/HxIqEKMgofEG5zQInYToYWtTTYsQ
        eVvTf2JQHl/HGvQxrUkYzSIpLmgIZJs5f/2yoOMj5Q==
X-Google-Smtp-Source: ABdhPJxLfPwEEBa+Ap9zKOritX0zyA/zOHrcclb56wSl9nFh7Fse60RiU41+kwlDQ+/tbTFIav2jJw6+dJm7B0eVyJU=
X-Received: by 2002:ac8:5c8e:: with SMTP id r14mr8329561qta.42.1642179488381;
 Fri, 14 Jan 2022 08:58:08 -0800 (PST)
MIME-Version: 1.0
References: <20220114114633.742-1-allen-kh.cheng@mediatek.com> <20220114114633.742-3-allen-kh.cheng@mediatek.com>
In-Reply-To: <20220114114633.742-3-allen-kh.cheng@mediatek.com>
From:   Curtis Malainey <cujomalainey@google.com>
Date:   Fri, 14 Jan 2022 08:57:58 -0800
Message-ID: <CAOReqxiSAhrSjXVW=D+ndXko95qLuHGkkNs5Wf-yVEcv1YompQ@mail.gmail.com>
Subject: Re: [PATCH v14 2/2] mailbox: mediatek: add support for adsp mailbox controller
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        sound-open-firmware@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +
> +static struct mtk_adsp_mbox_priv *get_mtk_adsp_mbox_priv(struct mbox_controller *mbox)
> +{
> +       return container_of(mbox, struct mtk_adsp_mbox_priv, mbox);
> +}

this could probably be inline


> +
> +static struct mbox_chan *mtk_adsp_mbox_xlate(struct mbox_controller *mbox,
> +                                            const struct of_phandle_args *sp)
> +{
> +       return mbox->chans;
> +}

also could probably benefit from inline
