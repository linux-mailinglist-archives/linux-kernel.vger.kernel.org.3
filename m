Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65A358AA40
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 13:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240677AbiHELkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 07:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240648AbiHELks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 07:40:48 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57241403A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 04:40:47 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id a89so3044181edf.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 04:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=pSKuz9BJS/Qwel4yBJUKsJP++c1z8gtIosTtEbMtN5I=;
        b=pCHOEWPwKqQot9WTqQQF6BvNGXvxWbDx4W7fkO7Qo8Uos+0AS2wBEMLJWI5x5Vl0iK
         TTkX1VsayFd4stUMYapx7wq0S72SCzwblXbLKuMRyJ4k+X8QzZAWQaHOZ0JdHQ4U58DS
         vJ0zpFPBGiRCXz1C0pGUnu49EL0oU4OzTHhocQHjgLLkAhMWbPA/2TUnnKatKnFtyVKA
         3esrvQ4CgBihBB7/v6og5YzWSs/hO+Jd0xGkTW1FHzv3JRmKHr39IxM5dCmNiFT2uXOS
         zsjBZZX3kOsGH72sKv9AX344PwnMQcuq+fPmkX4JqgvVYLRcQ7C8UzIsYIer6ZU1kw+l
         AhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=pSKuz9BJS/Qwel4yBJUKsJP++c1z8gtIosTtEbMtN5I=;
        b=e5+wSEbMijE0QLPRbI1atS9qMPkBlV5bX9NS7GruDX8IjaEU/BjPH+mHJbWVOgFqai
         EyQ0VFjc7VsGE+qGVEzbc2F608t28fijVp4dQ2OR3GDfJ9yr2wgHxp10V6v/5J4MdQdw
         u6o4pL32QSGCGQG7AbbG4W2AHBQt64w+JLGlyE3QTQX5TrrihZIuB/YNLRERSGMZFUWl
         NCRB3tCaYT6r8PYFNZh8depTIFzv/S2YdxXQYePRZXR48Q0dKtnrmV1YJoU8Taf2sa6L
         Ml4lh1ABHdlgJCPk5GSczogpwjTHtSiiep/eTWS1k0rWZhpgb6SvTnpVBE6QRndfL4MW
         OXGw==
X-Gm-Message-State: ACgBeo0p+7846NT2UD9adQ9r76VxfakQrSkg//4klaq2FmRWo+0jFckv
        9/vpTg1/jt4ejKweKBEvQUMVgZzbd3ZW4efPfVg=
X-Google-Smtp-Source: AA6agR6AezsnhmzqWrjzn5Rv/TUvxnElYMnKxk2iXVND+5qU2hEWP1FdcfnpRIijbsMe90npiEqpypNyVkKihw3vWMw=
X-Received: by 2002:a05:6402:3892:b0:43b:d872:a66 with SMTP id
 fd18-20020a056402389200b0043bd8720a66mr6169634edb.139.1659699646454; Fri, 05
 Aug 2022 04:40:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6f02:209b:b0:20:9820:bb64 with HTTP; Fri, 5 Aug 2022
 04:40:45 -0700 (PDT)
Reply-To: davidnelson7702626@gmail.com
From:   Alio Baare <aliobaare1990@gmail.com>
Date:   Fri, 5 Aug 2022 12:40:45 +0100
Message-ID: <CAEqq5Su8RZNWPnD_8sutOY0YrUYkCF=FOLxBUe-_MazkNRndqw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:531 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5327]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [aliobaare1990[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [aliobaare1990[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [davidnelson7702626[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello friend, I want to send money to you to enable me invest in your
country get back to me if you are interested.
