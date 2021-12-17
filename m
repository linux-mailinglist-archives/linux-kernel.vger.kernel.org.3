Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA649479289
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239714AbhLQRNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239705AbhLQRNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:13:43 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FA5C061401
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 09:13:40 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id n15so3363941qta.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 09:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=w0ePfBRpZ4tnDRs/xE4SxppW2MhJaXJI3jPg1l0ZidU=;
        b=d0r+zumEWRCd8edkxDtAelIdbks/tvrSjd2WRBcpFrggZYpGv8CcpuyYipF+dIcD4X
         ujm5de4JcFhieLwM3uDJ/7a9q+qbGcNj6odnsUrmY5hUkTJqN7RWtW6M62qsPCrmEN22
         MZ1PWjnfebddZ4YNdcZ+ItYvMVfyOeTazjqPIJrb5C4Njpce8ZF87VPpdK2bo8hOPORw
         UxIMl/WKvHz7KvQ2hQ0Vt39EH4VDRNM/mp+KF37kguTSzTb33C0AtevcY7YAi4ZydTF4
         QL8A7ILJWjdpr55XZ6yxqdbR2Z1nur635t9qEopilsGB9hc2oL+pa55JGJ93C5pTZNT8
         f1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=w0ePfBRpZ4tnDRs/xE4SxppW2MhJaXJI3jPg1l0ZidU=;
        b=lR5di9DILsX3fJ8dSplyGs1hA6wbSz2vlSXVV7xI7JJ00Gj7AGA+ueG9Ni60KjLxwK
         sVH5F7z6SLrfezlPiLMdL7pAHzwGkCWVlgwHizl9BvkNrj7w7pLI0LACBF9nWD5U9ama
         a4KKQf55GAwxnHDNaLck5KQxVAACzyswQcTGr7WCXi+eh14Xs0Br48wme7tbegHE0g5K
         iru2jfuDJVd0wmexS1F2KEwkEMEOCFRi6jHCTKs7ygK9oFlipQzHcMdiwGIp23mxE9wS
         9miFQsJqR8Cp0s13tuCybNFFlSU7eMiX30K3ynNYNoXkuKIfX5jRiJfq/XJvCKR04lLM
         eiYg==
X-Gm-Message-State: AOAM531BGanFrkzgLq8uo4PnEbY2ikAzW4rwbhA/WYJp/LrexMRyhoDA
        j7CVxU7PygqRJo5G0nVL9yh7cQ==
X-Google-Smtp-Source: ABdhPJxJBL27ebJZdMFF/QRhavMPKPNPSJTTnJf3ixn7JU2VNH70vq6aREGcCANw5VyzSQrlwn44Xw==
X-Received: by 2002:a05:622a:612:: with SMTP id z18mr3252353qta.616.1639761220040;
        Fri, 17 Dec 2021 09:13:40 -0800 (PST)
Received: from nicolas-tpx395.localdomain (mtl.collabora.ca. [66.171.169.34])
        by smtp.gmail.com with ESMTPSA id 8sm7864127qtz.28.2021.12.17.09.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 09:13:39 -0800 (PST)
Message-ID: <8438070708d16c34c0f79aba19e67fa343adb169.camel@ndufresne.ca>
Subject: Re: [RFC 0/5] arm64: imx8mm: Enable Hantro VPUs
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Adam Ford <aford173@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Tim Harvey <tharvey@gateworks.com>,
        linux-media <linux-media@vger.kernel.org>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Adam Ford-BE <aford@beaconembedded.com>,
        cstevens@beaconembedded.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "open list:HANTRO VPU CODEC DRIVER" 
        <linux-rockchip@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>
Date:   Fri, 17 Dec 2021 12:13:37 -0500
In-Reply-To: <CAHCN7xL4y67V6AW5MV=8iudvvGVBWs2LoUhu_2CUJf6bSycgFA@mail.gmail.com>
References: <20211106183802.893285-1-aford173@gmail.com>
         <718f7f6d6cd564d031c1963f1590c62d549ae725.camel@ndufresne.ca>
         <CAHCN7xKM9RUE7z-+ug1on+D=nDoEm589R4m03ofys92Aq75ZVQ@mail.gmail.com>
         <8db00a4b6faa99c940d9bc86e17161eb0db5efe3.camel@ndufresne.ca>
         <CAJ+vNU28UJffFv9jQ2KryJMudqYxvCaoVOVcU5dPqRA209iN6A@mail.gmail.com>
         <d91532c2c0772f9aa708ead36b2a97203727a7ea.camel@ndufresne.ca>
         <CAJ+vNU3H-V+bPoZ3qKead45h=W7AhQK6Lhjrx5ssdF4c_qfe=A@mail.gmail.com>
         <CAHCN7x+0LwwU_rEST+TZxGquswGKL19gnTy9WLofsXtGAtWqdw@mail.gmail.com>
         <7f94eaacfddb8c5434c17f1e069ea87a17657ce9.camel@ndufresne.ca>
         <CAHCN7xKRzxMBmPbDobWTuvNNSpTXk5XENvfBnfkhRY3eZKhn6w@mail.gmail.com>
         <CAHCN7xJFLNi_g+HX8PCy1Rkgf0jnWpO5QGYVz8nH19xrJkwHrA@mail.gmail.com>
         <CAJ+vNU3zFd=6k_Emc5aafxKkGwCPp4crgOFezQ-E_MbWsn1_EA@mail.gmail.com>
         <fed6c2fd7cf4971062c417ce41ed1e3812b900e0.camel@ndufresne.ca>
         <CAHCN7xK+wROHaqDcsY-3WYFQ82qX17L-LHNL3siSWnWvwFShzQ@mail.gmail.com>
         <CAAEAJfC1xXvemaFP+vTFVJ3S-SpYtrxyZgDamSOgLC1F3ua5xw@mail.gmail.com>
         <CAHCN7x+UMMP6RXsNm0=OC=UTQzh=RKqQo6B7FD5e4eoJAEfmpg@mail.gmail.com>
         <CAJ+vNU1epi9SwPMHkuDmKcb68RLemYF=bsp7AVnzz06zKc2efw@mail.gmail.com>
         <CAAEAJfCpjk5nWWkJYjjDT-YEpJi4pTZqZbzp_if9OGC0HKspzw@mail.gmail.com>
         <CAJ+vNU2we5mGXgYsR6CfimvFXZsc0zktR3fDa-h6RRa02jTT0g@mail.gmail.com>
         <CAHCN7xJrM9uZUnmx65uTxWEo6HAkjozd3kD3UoEv-pYd5DV4QA@mail.gmail.com>
         <CAAEAJfBXU-AiKKhkhXzgUSR4p1yefysNuHFycBz3F-GzNewS6w@mail.gmail.com>
         <CAHCN7xL4y67V6AW5MV=8iudvvGVBWs2LoUhu_2CUJf6bSycgFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 17 décembre 2021 à 07:15 -0600, Adam Ford a écrit :
> On Thu, Dec 16, 2021 at 10:49 PM Ezequiel Garcia
> <ezequiel@vanguardiasur.com.ar> wrote:
> > 
> > Hi Adam,
> > 
> > > 
> > > I will post a V2 last today with the Mini's post-processing removed.
> > > Someone, I apologize that I forget who, mentioned it was fused out of
> > > the Mini, so the testing I've been doing was with that removed and I
> > > removed the H1 encoder since the Mini doesn't support JPEG encoding.
> > > 
> > [...]
> > 
> > Resurrecting this thread here. IMX8MMRM Rev. 0, 02/2019 mentions
> > post-processor features for G1 and G2.
> > 
> > Have you checked the fuse and synth registers to see if they throw
> > any useful information about the hardware? For instance,
> > comparing PP fuse register (SWREG99) and
> > Synthesis configuration register post-processor (SWREG100)
> > in both 8MQ and 8MM could be useful.
> > 
> > As I mentioned on my previous mail, even if G1 PP is disabled
> > on the Mini, I would imagine the G2 can do linear NV12 (aka raster-scan)
> > which in our hantro driver jargon is a  "post-processed" format :-)
> 
> You're likely right.  I was going on memory from an e-mail from
> Nicloas Defresne who wrote:
> 
> "I will check the patchset, but you need in the mini-variant to disable the G1
> post processor, because this block was fused out. We didn't make it optional
> from the start as according to the V1 of the TRM it was there, but that error
> was corrected in V3."
> 
> In my head I assumed the G2 was affected as well, but when I double
> checked his email, and based on the above statement, the G2
> post-processing is probably there, so I'll run some tests with the G2
> post-processing enabled.  I'll also double check those registers on
> both to confirm what they read. I am not sure when I'll have time
> because I leave for London next week, and I won't return until early
> January, but I'll do what I can.

Sorry if this was a bit ambiguous, indeed I meant the G1 only. I've learned
later that the design of the Mini is that there is a good pre-processor in the
H1 block (encoder), so for the targeted use-cases this shall be sufficient for
most users (the output of the G1 is suitable for GPU and Display already, so the
post processor is not strictly needed).

regards,
Nicolas

> 
> adam
> > 
> > Thanks,
> > Ezequiel

