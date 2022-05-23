Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA8853121D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbiEWOkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237143AbiEWOkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:40:14 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A032C7;
        Mon, 23 May 2022 07:40:11 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id en5so19439528edb.1;
        Mon, 23 May 2022 07:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CHInJSNSNbi/9IsXYhqIDLfRLKuMZvSOB9ICsHy+xGs=;
        b=hf/CuAh4w8ydzt4S6oiTyYphf6Y3Cu91fMDD+KVCxU6ouMCImv/QzIoxg4JDTcMBtv
         SYD9haVBKYbwkly2VSyisZV8Vf9Pq8hNT/gcKzdY9Zlud28+ncs+qgPTPRLNjgT6cYbF
         CVqsI0x9eNx2TdAPviJs2JKxsvy8rVWSPW8Yy4jEEfucYBSAX4NhXEEx6xtsb7AvMfgn
         cFHlPvwuhUmuGLERCK3VJIr5it+YtEj5IkRO4ZXPpoGCqlPHscXeR/XgcHGSXD3Xmt2u
         Jf1dQi6e+Z/eIbnvW3wm5Ny9K26eYdx3XtVOTQK7BBFD1Xk7LVKb4dFyp8d0rghE2xTm
         gU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CHInJSNSNbi/9IsXYhqIDLfRLKuMZvSOB9ICsHy+xGs=;
        b=j+GjUBn/lqWUw6oOsvdVGMCAFKyetB13bXFYakhPx5uoByqyb3V2m43r0BOuCRp+Vq
         83XHdGThg61nAodQEcq8yrqa8FkoZ8u7bz0taGGaCN5oDyvzKejYkarRGVHTkpgVwRU6
         92BN1U27njv2DhZhhD8npW/rH0Ll1Mi9JuII09VSIwnT9ssZDuMJ8XJk7JQ557Txne+n
         35ifsC/A83kRTn53q0Q90FUj8CgGc6dQIkMn2nss/k/PZzHS4Oid3YXJ2Zc0gNV3BndA
         PTfcqd4OsO120AF6mRZD/JaRxQ4vvXUC7b9aT1HIsgNDhfLG8isvzXR+ywzKZJU6PqKi
         XOQg==
X-Gm-Message-State: AOAM530JlKborlYsMybfuvQ92d6s66DCjxt/Cb/VltgOWq1og6vqaLgj
        qIKxeK7OehHxyBdy+e7xEHX749JKGcz/G/EUYyPYYLs=
X-Google-Smtp-Source: ABdhPJxDjTYy7IdZIhIVspU1ND/ZK1G1NZBzfzttih8jd38AONVLGwesNGkRYAIpbbXoi47i+QzrVCqHs+UxCBmFoQY=
X-Received: by 2002:aa7:c79a:0:b0:42a:762e:769c with SMTP id
 n26-20020aa7c79a000000b0042a762e769cmr24118054eds.155.1653316809635; Mon, 23
 May 2022 07:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220523140525.4ad591d0@canb.auug.org.au> <4d5c0dee-b32a-158c-e243-de2c4af7e103@linaro.org>
In-Reply-To: <4d5c0dee-b32a-158c-e243-de2c4af7e103@linaro.org>
From:   Rob Herring <robherring2@gmail.com>
Date:   Mon, 23 May 2022 09:39:57 -0500
Message-ID: <CAL_Jsq+ohio4ELL=RszN2vavg_sZ9S-N0R_TeQ9qpjB+ehCwTA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the mailbox tree with the devicetree tree
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        David Heidelberg <david@ixit.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 9:33 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 23/05/2022 06:05, Stephen Rothwell wrote:
> > Hi all,
> >
> > Today's linux-next merge of the mailbox tree got a conflict in:
> >
> >   Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
> >
> > between commit:
> >
> >   b20eee62ee89 ("dt-bindings: mailbox: qcom-ipcc: add missing properties into example")
>
> This commit should be rather dropped, because it duplicated my work
> which entirely removed the example.
>
> Rob,
> Can you drop that commit from your tree?

No, but I've reverted it.

Rob
