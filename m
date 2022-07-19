Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0313357A46E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 18:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbiGSQ5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 12:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236150AbiGSQ5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 12:57:45 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2983BC98
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 09:57:44 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id h62so27461142ybb.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 09:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o7+Ubqiy2+BoQin6yNXc+QNXIGV5Q3/BvbuwbIYCyGg=;
        b=jDXkeIvMaaX/KM8OK3qGh4cqNKE0y+laqha/4pyxS+Wu9fXAg9Yhh3QLTiOjlM+J0e
         RL5pWZx9ylPGVE7YBV/3GXFLSWkxjJbAHdmuCyVjVW7S5t1xm+aXQ++ITQecPxuB2ZSQ
         21xbWTeoYIC4juF68O4CBY8fnBwZavDWa5ayCvkrEOfrRg2+pZr+QPXACyeO8vBeHAr+
         gt4/y8eqNnY0vkljn4Ttjd+xoeqYvTAPjQIRJGL/6ywbqmF/B5dHciDR0dPO3F2g3CsE
         7faKUhRiBzgTCSXoUl1h8+rUqa6NvV0nUiMvTb2b70yJMCBiZJQlHvW1JcqxV8YcqksZ
         yyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o7+Ubqiy2+BoQin6yNXc+QNXIGV5Q3/BvbuwbIYCyGg=;
        b=eeCcDZ9YK+hVAhA5PWnl615LxkxgES1ABuy5oYJCxeDFcdJK7gCv6XnBCMaG2l+nIS
         8KxBV4hvaMrlSYqQZNyJ8vnGMRCfDd6Ne60YokDYwvguvv/JJlnjr0WyfGTajnu0BrxK
         ZE27gcDNxsFMxQBCgrvbfGwoN3d18NVLMbj0C3jwpjAhOegmk+j/gjq/vXbwx3ZWWoog
         cik0292mi5rgdaouG2cUfBuN4OWqoC1SCgaDEYJpumhEEQlSRE1nS2aOvRh5dS/Gzj2o
         GFOmFruFjISlipsX6krkxi6c2hxb3xRyBbVNYzzZy4W6EPtYRLZEqeDBLzdXTrg4oahf
         +BvA==
X-Gm-Message-State: AJIora9eMHcx2WWtOrzIIcKjnyF6DODaqPooMZR6LnWcRih6naARlLz2
        pvYTtrURax9Z64J9xYlT9hkYOlBWM+l10PJ869sn7w==
X-Google-Smtp-Source: AGRyM1vhzpnhocRnv6ire6qDfWb/9m1NX4vbI7Nl70MF+plSrK87qGhyAJ+RRq3GP3Hg5/lTTEQbR1GKREJvb41sZFE=
X-Received: by 2002:a25:9b88:0:b0:66d:b166:a430 with SMTP id
 v8-20020a259b88000000b0066db166a430mr33323156ybo.80.1658249863775; Tue, 19
 Jul 2022 09:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220705083944eucas1p23419f52b9529c79c03c8cc23e2aaf4c5@eucas1p2.samsung.com>
 <20220705083934.3974140-1-saravanak@google.com> <7482d3af-4b02-4c1d-0386-b0a4ddf529da@samsung.com>
 <8a04332e-e7b1-8bc3-d569-5052427bcb13@samsung.com> <CAGETcx93rWqt-Cyz_8JZ4mxcLpJruzSM1QOAgpkPSM-G1sBXWg@mail.gmail.com>
 <20220713145827.yxeoqj6vmkzhrrpv@bogus> <CAGETcx_V9qxeO+vks8kwpwWZth+fys_TTt=JwV2JkvUNHvTtvA@mail.gmail.com>
 <20220719133931.7dkcejvc6s4a7y4z@bogus>
In-Reply-To: <20220719133931.7dkcejvc6s4a7y4z@bogus>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 19 Jul 2022 09:57:07 -0700
Message-ID: <CAGETcx-YSVunJv+xpHd3PD4O8m=C5JjBh5b+h+6WnEcUAr=5_g@mail.gmail.com>
Subject: Re: [PATCH v4] amba: Remove deferred device addition
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 6:39 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Mon, Jul 18, 2022 at 06:55:23PM -0700, Saravana Kannan wrote:
> > On Wed, Jul 13, 2022 at 7:58 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Tue, Jul 12, 2022 at 12:38:33PM -0700, Saravana Kannan wrote:
> > > > Sudeep,
> > > >
> > > > This makes me think the issue you are seeing is related to your
> > > > hardware drivers. Can you look into those please? I'm leaning towards
> > > > merging this amba clean up and adding delays (say 1ms) to your
> > > > clock/power domain drivers to avoid the crash you are seeing. And then
> > > > you can figure out the actual delays needed and update it.
> > >
> > > I haven't got a chance to debug the issue on Juno much further. One thing
> > > about the platform is that we can't turn off the debug power domain that
> > > most of the coresight devices share.
> > >
> > > One thing I also observed with -next+this patch is that with a little log
> > > it can access the registers while adding first few devices and then crash
> > > which doesn't align with platform behaviour as we can't turn off the domain
> > > though we attached and turn on in amba_read_periphid and then turn off and
> > > detach the power domain. Ideally if first device amba_read_periphid was
> > > successful, it must be the case for all, but I see different behaviour.
> > >
> > > I need to check again to confirm if it is issue with platform power domain
> > > driver. It is based on SCMI so there is some role played by the f/w as well.
> >
> > Yeah, this log timing based behavior is what makes me suspect it's not
> > a problem with this patch itself.
> >
> > However, just to rule it out, can you try making this change on top of
> > v4 and give it a shot? This is related to the issue Marek reported,
> > but those are more about permanent probe failures. Not a crash.
> >
>
> This patch(version v4, fails to apply on -next but the conflict is trivial
> and in the deleted code so I just retained your copy of all the functions)
> plus the below change fixes the issue I reported on Juno.

What the heck? I didn't expect it to fix the issue at all. Without the
fix some amba devices could end up not getting probed. But that
shouldn't have caused crashes. So that still indicates some issue in
your driver you might want to look into.

With that said, I'll just roll this fix into a v5 and send it out.
While the revert would fix it, I don't want this to be blocked on that
or be fragile enough to be broken in the future.

-Saravana

>
> I won't give you tested-by yet as you have plans to revert some things
> and I resolved the conflict here though trivial, I prefer to apply the
> patch as is with all associated changes and test once more.
>
> Thanks for digging this and fixing it.
>
> --
> Regards,
> Sudeep
