Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F044FF571
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 13:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbiDMLKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 07:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbiDMLKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 07:10:38 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4FE59A66
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:08:17 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id u2so1472111pgq.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=xVJHepNq93ePmAbCv1LHbdOWJcqWYQh8v11fr0KUdVw=;
        b=YOZLCENnStMtRvwjWoQo2qM3zGtnCTT79CQYt/EuNg/HPqL37277I6GnlyJIgbPAdT
         eBbZXla/WxHMmGMNmpXJPkgmh20GT6M1lKIw6JXL9D3d0eVLTgqmrvQuPTlHCJlcrobU
         nxU0wlZhUw+wKvt+ioe5jqL9eFi57zy83QNsjk6o5w3Ax0d/h+Yp7QgqFXh+ZG48gTxp
         2h6sIH7gxqTKmKrdhRu3xFsGaibqJFLxWRGR92ZAmJFJphLGZgWybdb+9XtdC5Ff5EbV
         vr537rqGV0puZcDGpM2Oq6zr+0g+5T0/p4lCaKYtcOaY+MlsVOSFZhOXzwIr55Jl5T6w
         Hgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=xVJHepNq93ePmAbCv1LHbdOWJcqWYQh8v11fr0KUdVw=;
        b=ZIU4cDb8j5RbiZ2xn90VobfAppGZMucJbVlFw7AMgXK/QaD3f2ztqIEwfSN3yd8FGf
         RFKJFRAho9U0dawIX/YCuiDUBBlfppdXmxNgikGMSRawXOPnKZFESYzWGK6BGIE/tXUl
         9OTFMC38eMwUR01VCMgioA6ctl+wcUwb4TR32obfPznDWDHWuZ5Wpc0EhtfJmQFnq4nB
         vx17dkk6dfzWSdNN9fNa1Er7/MzRhXHcmb10X1+2/9ZBoqIkYn1lXCB1iUMywS8QQdko
         o7maMJ788jmhezJIRKF4/R3ubqgxin8GjWZuqpAwBCHxPUPWzCPqeZuhVw94cWs0hZ+g
         zHsw==
X-Gm-Message-State: AOAM533i9RozyXFSvyvEqMnyINkUekohKRQVX5IdWtEImToMXz8fIZbI
        bVCI7SBafEFIDwoqYNpa0lasBhen8L4q3XYtE1A=
X-Google-Smtp-Source: ABdhPJzAn6uo14GmVdzxSxTOA/twFx0a3m6fh0+8YhUA1DFosRRsJNqJ1GLx3x0ZFOaxnVYfrUKFB/sb21kRhq7wIYI=
X-Received: by 2002:a05:6a00:f92:b0:505:c53b:2668 with SMTP id
 ct18-20020a056a000f9200b00505c53b2668mr14512993pfb.64.1649848096435; Wed, 13
 Apr 2022 04:08:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:b394:0:0:0:0 with HTTP; Wed, 13 Apr 2022 04:08:15
 -0700 (PDT)
Reply-To: lilywilliam989@gmail.com
From:   Lily William <osasgoodness8@gmail.com>
Date:   Wed, 13 Apr 2022 03:08:15 -0800
Message-ID: <CANczi2wKKbRdb6wz3czKEb=0oZT=DptMbTfMmOMgCddeQzKgpA@mail.gmail.com>
Subject: Hi Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:532 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4981]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [osasgoodness8[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [osasgoodness8[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lilywilliam989[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
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

-- 
Hi Dear,

My name is Lily William, I am from the United States of America. It's my
pleasure to contact you for a new and special friendship. I will be glad to
see your reply so we can get to know each other better.

Yours
Lily
