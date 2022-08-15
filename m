Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FE059340D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 19:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiHORaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 13:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiHORaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 13:30:07 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D6F10FE0;
        Mon, 15 Aug 2022 10:30:06 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id 17so6907817plj.10;
        Mon, 15 Aug 2022 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=F0hCBcrwh8QkXDe6xrNwIb9T4L2AxzqLMvkfnlDeEVA=;
        b=WghDQPv2e+/ZQECJxdKOFSv8PuR9eM4UDstNVw2Jss0pSIeC7ULV/S58XTOsbZTd93
         o0WaxxrLJh53Bfj3GBFf6CEjKuDkRecNlLJoAc36gni8XgpTxfmRhfsnnb2AC1o95Uid
         h4JNKdf8j9XcrlN2qly/VqxmzsifhMRRShxwpEMTeHe+/m3XSOeXNHhGX1Ud3d+yFZTk
         YzHniPfiBTICkOmXHWx5fmQGuAS67c75+hlzOtWmjKmCPJbeaHfQdh3Uhw6hCT+ZHS4s
         QiE1pNUwS7QOzVobAoeMfdtRR+c1RNVZpdsRt+sm9BmRj+QKFCkM8p87eIXDweTMeJ0/
         EoAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=F0hCBcrwh8QkXDe6xrNwIb9T4L2AxzqLMvkfnlDeEVA=;
        b=3KEZvlszcQOW8vAFPfILVBw6NmMtwpkRlbjezKIEcWgoQn6kZbdGjZvAgxkY2NoXag
         e9BdA6rZ9rBQDU8PhjrodbwfFcAnQCoY3N90wbWhm8auMoLdJTsmij8zE6YTChI460ec
         F+L4t7JwWWPVXB+5GqCAIU0zgXE1A224Pbn8GKfs7iNM5WTVvFRoK4L1WYk7ZOBqwrTF
         XU5UzLXiXco+iN3CsDZfyy/tHecefQCXRkfCD+2V10Z4ppGzg6qgRv2oWjJ+bIlSYuyG
         e7ePt2di+CSo6R6BlXbdSue2egQEV/xN2WdaJJ0bmvKjD+2iW+es+//inEgweBTV7a2D
         96HQ==
X-Gm-Message-State: ACgBeo0dj5bnknEVmvegjLTvt0YuOa0QKgYJWJCcadqTrmZCvRKY8SYa
        x3mDyNn8cPeB70HARh5BC/qZhv2wfi8=
X-Google-Smtp-Source: AA6agR6F0vIW0KBSJjTs3GzGC3tSc5bnsZJBUjG+nATrNDkJpjv7sg7wdeMs1+faN2Y7CtDf3N4Hkg==
X-Received: by 2002:a17:903:24e:b0:172:6c9d:14e0 with SMTP id j14-20020a170903024e00b001726c9d14e0mr6884114plh.84.1660584606237;
        Mon, 15 Aug 2022 10:30:06 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.52.254])
        by smtp.gmail.com with ESMTPSA id dw3-20020a17090b094300b001f312e7665asm4742099pjb.47.2022.08.15.10.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 10:30:05 -0700 (PDT)
Date:   Mon, 15 Aug 2022 23:00:00 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] ARM: dts: integratorap: Update spi node properties
Message-ID: <20220815173000.GA45630@9a2d8922b8f1>
References: <20220312113853.63446-1-singh.kuldeep87k@gmail.com>
 <20220312113853.63446-2-singh.kuldeep87k@gmail.com>
 <CACRpkdafQ4G=a1E=G6GK3W2zAD4Nh96GiQiYbYkn4ctVu3c04w@mail.gmail.com>
 <CAL_JsqJ2p+4R=-HcKJ=UdXFcATrZgwwpfRnJES+-bHxRohorHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ2p+4R=-HcKJ=UdXFcATrZgwwpfRnJES+-bHxRohorHA@mail.gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > This and patches 2, 3/4 applied to the versatile DTS branch.
> 
> What happened to this?

Thanks Rob for pointing this out, I lost track for these changes.
I just noticed Linus applied ste-dbx change only and skipped others(integrator,
realview, versatile).

These patches fix clock-name as per pl022 binding which causes no harm.
Linus, Any reason to skip others?

Regards
Kuldeep
