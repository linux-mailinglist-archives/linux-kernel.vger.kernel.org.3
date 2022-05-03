Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE562517ED1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbiECH1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbiECH0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:26:36 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F97F3917D
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 00:23:01 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id x18so3114041plg.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 00:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dYOKOnX/ag89Q7FWf4mTvhnDEvPe9ePWto1EYZGs+OQ=;
        b=kJL+2m3UswGuMwUa2ADnBKx9k7XiM5W2DhfJJnyiYigWx/2+gpJi9pNp+p5CwvOkpJ
         VUs9E5GM/VNuRj1ZxO3KHDcQDVZ/O7X1IQTsVeiD6MMn+j7VYSU0CRis9H7/hjkkpL4s
         oXCheS3gL/+nL90EFP4hNrVHEIc+hFzauf2IHKpXBZe1VylWQJRily8n9UdrzAIvTr0H
         OTZGXUk1E0WqjSRV3FVBRhf8r/mlL4/IMfyAF+5X0eLOyyWaiHrpT/q08sNGvSH5LI4g
         A/wd7jyOlLmL2UMjYCalSQaZzL2YMi50+eCTCQdcE2A9V8pxHd68kL7swWWc1y6oZvq6
         Hz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dYOKOnX/ag89Q7FWf4mTvhnDEvPe9ePWto1EYZGs+OQ=;
        b=XG6V4WUO8tu+0qKaFjT46uAV5dKLh7D6p5kJlWutEUP31HkRKrjemFwGmGrr95oNWy
         Qjelw/bQP75dlrNGHyA2exP6pD8lbHfyODc6Js8/PDjsT22DkAPlvVnMBiMoO5SCWYry
         vUKV2EtoB0Zse4g9h3xOrEBNGX63yJZUy+PSAbxCtAax3oLYRxchNRWKQBRT0rbhPloQ
         bK/Nb5XvkErEaKAnYu5BTHSajRykPtYZEB5ItVxNfhFlvxJIl9Q8np6wVsrv7zCQ7X7H
         PX9XUAjpsENqReANqTNNlxwseYYsKu17cqj7zE/b77ROj458NwGD7JE1QfOIy0vXiKwd
         Ffow==
X-Gm-Message-State: AOAM531ReYcJxFFyFivHphjtJqi3WPiKapW4gaQ4+EB+VURTPHv2gTRV
        iTg68lCNgLiJR0s1977U2/uFeHi0ir0pvWW4VOLPcQ==
X-Google-Smtp-Source: ABdhPJw1s1JswARQvRGebofKaxoOTfTVyYJCUT38LUSf+snPURnEtm8yFrO3id35Fi7bWxmtCBqqpDNYEc7nKS57z0E=
X-Received: by 2002:a17:902:70cb:b0:158:424e:a657 with SMTP id
 l11-20020a17090270cb00b00158424ea657mr15285007plt.6.1651562580619; Tue, 03
 May 2022 00:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220503024349.4486-1-slark_xiao@163.com>
In-Reply-To: <20220503024349.4486-1-slark_xiao@163.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Tue, 3 May 2022 09:22:24 +0200
Message-ID: <CAMZdPi-F96cLTXjCvVEQ7udpbk7KOBsqpMD3E03bE_A+Pkx8JA@mail.gmail.com>
Subject: Re: [PATCH v2] bus: mhi: host: Add support for Foxconn T99W373 and T99W368
To:     Slark Xiao <slark_xiao@163.com>
Cc:     mani@kernel.org, quic_hemantk@quicinc.com,
        gregkh@linuxfoundation.org, bbhatt@codeaurora.org,
        christophe.jaillet@wanadoo.fr, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, 3 May 2022 at 05:03, Slark Xiao <slark_xiao@163.com> wrote:
>
> Product's enumeration align with previous Foxconn
> SDX55, so T99W373(SDX62)/T99W368(SDX65) would use
>  the same config as Foxconn SDX55.
> Remove fw and edl for this new commit.
>
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
