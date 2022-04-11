Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB864FB296
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 06:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244400AbiDKERE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 00:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238299AbiDKERB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 00:17:01 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDDABCBA
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 21:14:48 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id u2so10081031vsl.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 21:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=KeMi8W+p20zdR41YZoRj2EapY7imNsLYkAgQIQsIzqY=;
        b=WxkdM/JmJUYzzrEUgt34EpDOfpORrvOVr67Fx8TpX0rVScdrcTVlfL5D1Dd7zzDKje
         53KaIHnV1wKyTyT3UxojXYdTM7oDZ0aPF/H+/weJVmV5nvRuWGUJ+t16NyLUxaPufLdo
         tCHuaCIyyoyXuSdf/7Mgj4p0fauhGey41EvJktZ6Aq70g2JcS4DHEP6mlglI5g6mqepd
         eSf2gnYq0AXMgw1pDtmxLHwSOfojNjkcz4DDR89RgxHEEWFaZ6Am4cupFj3r+ZjzI9iy
         sKQB/6Dpsuc/fMh0cWjNHCyHlK/Q3JCD+jAwCgR4d5cbBrjhAXrCCFGkVmevNBHcvmBr
         P83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=KeMi8W+p20zdR41YZoRj2EapY7imNsLYkAgQIQsIzqY=;
        b=UP0oMzgK9il0cIxvxVu6SX5+egDzWMBpt24kvoB1FSqlNaLzPQ+odC1mrz66ChKaTl
         NBflbKood7Qv9RV+Mta1buDB7gxL+d1qer7RydVoePflwssvDaSxtfX1xNXIrmsCkZOi
         1eu/nTLihl+QzHQFkLDKnx72s4icZhJ0h2+sCkoNBwVRAKIKG/7riL4POGI6VQVpjRhc
         HMGKIT7a8tClHhoXQeI9i+PSBszdhYFyCBH3BbRQnCOTKZ86gsXcpOopFAFEzyolTGxT
         PFMfN/C2L0t6Mxf2m+ClpKKSznCS10Z8BKHh6h3PYIpRtSrtYIk/PqtrKpaDsby8pgIZ
         ru8w==
X-Gm-Message-State: AOAM5321FyVDiowge+42yc5/y88b3XoaobnSd7K6QMjzpFGGDKWgRw5m
        wdBLerAsC/Tdr1E376WUysYgHQ78oQFbsQ2VdbU=
X-Google-Smtp-Source: ABdhPJx2wKd44dtjrFToYlzx+424BcguAcgJc92sXvKPGMX5nVxvh2PgM2sP4jl9t1sk7St043askSL6f2fQDw4cPeI=
X-Received: by 2002:a67:eec9:0:b0:324:c32c:dbdd with SMTP id
 o9-20020a67eec9000000b00324c32cdbddmr9321677vsp.33.1649650487941; Sun, 10 Apr
 2022 21:14:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:25c3:0:0:0:0:0 with HTTP; Sun, 10 Apr 2022 21:14:47
 -0700 (PDT)
Reply-To: daniel.seyba@yahoo.com
From:   Seyba Daniel <hadissawilliams@gmail.com>
Date:   Mon, 11 Apr 2022 06:14:47 +0200
Message-ID: <CAAC2S9n_8svG=A=FXD=Rve-Vg+_BOkTZPAfg6WeSQoarJvzPxw@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5009]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [hadissawilliams[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e44 listed in]
        [list.dnswl.org]
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am so sorry contacting you in this means especially when we have never
met before. I urgently seek your service to represent me in investing in
your region / country and you will be rewarded for your service without
affecting your present job with very little time invested in it.

My interest is in buying real estate, private schools or companies with
potentials for rapid growth in long terms.

So please confirm interest by responding back.

My dearest regards

Seyba Daniel
