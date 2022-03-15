Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4DB4D9C24
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348650AbiCON2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345854AbiCON2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:28:05 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A063464B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:26:53 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id u124so20713682vsb.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9EPLFc0pdiuZLGXfUBeoV2QJLlEOKY+cBVSdJpmJdi4=;
        b=Cezrbq+lnRkFY0MX7mLsPbWtmtsVEYwFF0sXofNAVhJqqsedLgC8CeZk4WC4sVzpHm
         tvUN8w/6Yl3GJQBsuhQIKFUCthYzCBaw6fymHmE0OpKWrv7M367uk4bRhGGRpoVh+QSY
         +8plcP8lKntM5RNuAM20n+Dr404RQhdw/vCn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9EPLFc0pdiuZLGXfUBeoV2QJLlEOKY+cBVSdJpmJdi4=;
        b=JY/sLd47g9vySb82Ei7UiY+UacURmQF7zaUENrdt525yX1yw5ITlL3zOrvXHKH4WNP
         M+N0uLQRSijhuo05dZ4CTkzlnJB7LlCP9h9W4Lxv1esDQaxeZ2rYApyS8MXW7UfpWKXs
         Tw2Afuolj06IEKeZDttym2r+Y0jSdNVTo0kHJiLoitXvxxS6RB6atd7IAsiCtfEihP4U
         0ML31DIE1NrSClKJnzXq2OINIUDodvRmSmqCqdvZzWBA64iK0pYlFEWDodR9tskOM0oa
         S7bQlAyr0SwwACdDui8zrIWxQNmdvTXtXBQCPNdcSiu0T7WJoad++hJAW8WyERsqrbgJ
         bXpg==
X-Gm-Message-State: AOAM530stABE00pav5hRTdVAdE8+nxsFM9fAzF7u37P0DRLRAHf8QlQZ
        EiEhatKpnRWj7s1vt/xnOSeg0j9kR5uLGnFketMZVg==
X-Google-Smtp-Source: ABdhPJxwjbIQYTYfnoZMHaBdjvlurSIvTJDn2QMMRqzQ9bJmaqZBacvvQyMn7vZEJQ7pL3Sgi+3M61OKTD+3EpMCktw=
X-Received: by 2002:a05:6102:c4d:b0:322:b188:3842 with SMTP id
 y13-20020a0561020c4d00b00322b1883842mr9866634vss.12.1647350812654; Tue, 15
 Mar 2022 06:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220315091319.3351522-1-daniel@0x0f.com> <s5h8rtba4to.wl-tiwai@suse.de>
 <PAXPR10MB47185B76D5F38482FB1125A5F1109@PAXPR10MB4718.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <PAXPR10MB47185B76D5F38482FB1125A5F1109@PAXPR10MB4718.EURPRD10.PROD.OUTLOOK.COM>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Tue, 15 Mar 2022 22:26:41 +0900
Message-ID: <CAFr9PXn=vRV4Jvxc+w9XJiAB8eAzq9MUfu+frMkS1P83Vp2Ujw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: sti: sti_uniperif: Remove driver
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaud,

On Tue, 15 Mar 2022 at 22:15, Arnaud POULIQUEN <arnaud.pouliquen@st.com> wrote:
> > Yeah, that looks dead.
> >
>
> The platform is still used for instance:
> https://lore.kernel.org/all/1d95209f-9cb4-47a3-2696-7a93df7cdc05@foss.st.com/
>
> So please do not remove the driver
>
> The issue has not been detected because it is related to an error that
> occurs only when we reach the limit of the platform, with application
> that stop the stream at same time.
> So almost no chance to occur.
>
> > OTOH, if anyone really wants to keep the stuff, please revert the
> > commit dc865fb9e7c2251c9585ff6a7bf185d499db13e4.
>
> Yes reverting the commit is one solution.
> The other is to clean-up the snd_pcm_stream_lock/ snd_pcm_stream_unlock in the
> Handler.
>
> I will try to address this in few weeks

Feel free to ignore my patch then. I couldn't find anything that used
it's DT compatible etc and assumed it was orphaned.

Cheers,

Daniel
