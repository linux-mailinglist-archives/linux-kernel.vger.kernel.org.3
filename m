Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D84530643
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 23:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351648AbiEVVio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 17:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbiEVVil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 17:38:41 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F6837AB4
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 14:38:40 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id t13so1827845ilm.9
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 14:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=loDvYEF8t7bLKVjfnhfY6pWRpyY/6/eNtoU1TRfTF48=;
        b=ALd0mfFnhi009D0ZiC0QogIrl3EisXc84NQwqF3TwYkieurp2ZJ3aRdgs3bzo+tihd
         cIXhTLAMn3HcL16sv1gyNgcs5nel28UUW79qsg1tHoOno2UbmiG64ytPefdlxUgnDxN2
         s7KXcgK5zdyj83FeT4m3U0cQVjL4mIwv1zUBxcr97w90mqHAo9/+87m9to4HrtW47zgg
         OpLxpYD3P61edjLB/54RSoTacKCd9tGPsDNDgQQpSEU3JYwNYlF+6ZOeHNW4MSZB5i/T
         MzG1ILuj4va0u0Wi5+0Rl5shgv5XXK9zR3G1nTimEBipCzayHQhLBjBiB+Vv2NEx8Cxk
         sYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=loDvYEF8t7bLKVjfnhfY6pWRpyY/6/eNtoU1TRfTF48=;
        b=8JP9oUveDV9EMzYPNJcSpitYEIqasrNbgEFdj9S4kfFGPjPOpTxt9b404R+pzVlScm
         eRhZnIhPQ0Rg94Tux5rE71X/pi9oFwcVTroaD2DccuIgqY9SwVDPnlXZtvFdgFh80bso
         tHi7eJA6rSqx6YGA/Nvp9+3M0TaCSQvi6RSyepLjGMF+6PZKYSgf4oMk+Hwu/kZpGt/x
         ZYQ22lf9ey8vkSoTTaerqsFim3bGZ7EmbhrK8GTrElgU6uD3WIh9sCYO63YF2INgPrEG
         8F5TNSG6C0SUS4HOr12oTjDpA6AgDuwhCIk+ot3njH2z3U24ghDdO5k39P+FoPS5wbD8
         dtwA==
X-Gm-Message-State: AOAM532u/tkTdxq9pu6qtOcZ57fawQ/50Jb8oU+FYELON77xinXwSrT6
        Gh2S+Dhy4XkRGcTBRkV49sp3PGSM/GLDZ1NgRf8=
X-Google-Smtp-Source: ABdhPJxKxWbxjWxq4uMAWfFhDR7cqQBiYyLz91DjNgMOG9cQ5pCTWwHF/9mGV/9kep3uKo9MpMTscIoEXklmDoSYacA=
X-Received: by 2002:a05:6e02:1a82:b0:2d1:6d48:db99 with SMTP id
 k2-20020a056e021a8200b002d16d48db99mr8506012ilv.232.1653255519432; Sun, 22
 May 2022 14:38:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:ba08:0:0:0:0:0 with HTTP; Sun, 22 May 2022 14:38:39
 -0700 (PDT)
Reply-To: jameskibesa@gmail.com
From:   James Kibesa <steveko833@gmail.com>
Date:   Sun, 22 May 2022 14:38:39 -0700
Message-ID: <CABnqBJfP8WNGLwbmiM6uA_kTriJU+=65nZRhVyxzM881h=0ESA@mail.gmail.com>
Subject: GPE COVID-19 relieve funds.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:12b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [steveko833[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [steveko833[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
You have been approved to received GPE COVID-19 relief funds. Reply to
this email (jameskibesa@gmail.com) for claim procedure.

James Kibesa


Chief Financial Officer

Global Partnership Pandemic Relief Consortium

www.globalpartnership.org.pl
