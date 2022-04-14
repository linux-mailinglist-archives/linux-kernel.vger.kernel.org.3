Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB3B500C39
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 13:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242318AbiDNLhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 07:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiDNLhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 07:37:09 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D255005C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 04:34:44 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id v15so5926710edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 04:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=PYxTo8ZxKxKKVP3Pzfz2TfoURp1SYH8v3TPGTzBEIgh0lrUhD4KiuYEZuGyz36dhmw
         ws6BRhX8qUAabv9+iWRu3zceFkhV5/RvyvVU7q0ITYtnEoRCYXxJ4vuKW5GT3kEd/hx+
         JaURbnad/hNSbQvkrkR+6Lh7dUXWSGEAvRIJJevTM8HIEpT/mjqerkGI2pnxC/ZxeTX+
         oAvPu0G325UhmWDA7IZ0UuXHoDA7+gd/9nsWzegsgYWBQsORkmAjna77Sl6luzndAQvS
         mrrwxTU3GCppMVufqUxz9TF/+srGhKaC/i0Swy6LcvV0JPaHP+KUrMs284yfIcw+ujsy
         OYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=XXVrgJ9A3D4oLHe/95AFDQQ1lDK9bRb0D7Vxs/HZtlgOMzxdaLbeairv8Vsf8lP8jE
         bqwEXHJ3jITKDqu5sgi0WHP4bWjvRMi8FlvPZvUIhgvc0Vs4zH2DcNAS3EijD3zLAggp
         dlCBenkyTNOeSZuim1wYd2MC1VDZ0eS0vsmy16GBnPH/1tT4UzcD+jDJz9ISigIYCHeI
         qZI4Mw3T2Dp2pplLamwTQDktydvJLTqRGA/wNdTqtLFhAASfwjvm3PRYQDjL6+aoLW9t
         j2oyjlwVrUxzyICOWq68O+AKppjgMGL63cbsNC7QwF/Ww8fGYQOc9ZafI0S46MU03S/s
         bkzA==
X-Gm-Message-State: AOAM531dULs460EgvnhlalQYLpM2sdVixlhLN6BC+ZErOopoi2dLI0ue
        zrYqzJwEn0mOWsRgNCHDuFlhFNsIg1QsypfJGzc=
X-Google-Smtp-Source: ABdhPJzTU4UYJTo3XM9jLrQhad1Ap0+RMiDSn660fryvy6t6s1YBlW5ifIlvP8AMOQ+bsAxiLD1JsbO4Xf+HkVnvYo4=
X-Received: by 2002:aa7:cb96:0:b0:413:8d05:ebc with SMTP id
 r22-20020aa7cb96000000b004138d050ebcmr2464799edt.81.1649936082644; Thu, 14
 Apr 2022 04:34:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6f02:208e:b0:19:65cb:7453 with HTTP; Thu, 14 Apr 2022
 04:34:42 -0700 (PDT)
Reply-To: robertsodjo63@gmail.com
From:   Roberts kodjo <tinleyaburo01@gmail.com>
Date:   Thu, 14 Apr 2022 11:34:42 +0000
Message-ID: <CAG=2wjvgftx1gXFS_31-+K_ky8Q0ij7-egdPjcjbh7g0qYVBag@mail.gmail.com>
Subject: Ich habe dir vor 2 Tags au a vorherige Nachricht geschrieben, aber
 keine Antwort von dir, warum?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:52a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4899]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [tinleyaburo01[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [robertsodjo63[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [tinleyaburo01[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  3.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


