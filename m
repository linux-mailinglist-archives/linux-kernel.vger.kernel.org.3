Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E3A5875A0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 04:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbiHBCsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 22:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235785AbiHBCsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 22:48:00 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00281D332
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 19:47:56 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-3246910dac3so75523907b3.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 19:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=IniFjyVHQ6lWflzIsICmJ5JUtVB9MkE1WWkHF07cmBg=;
        b=ObBUjTPeKodZO2og8CYdsGYKwWefnEsBjc9+sKUNfLp8LomSZcY1rrzCvvrtADl3ij
         XakxLkQrNkAaI6+J1fwGJHWlLJVFCgpPbmGZMQY1G4TkmlkTN6JisM/kQH2ZBBg4DMCW
         k6Lyp9COH7pey09475Q2Ec7ecjCe3/7jSGCTzIHlf+PFeV35CIqg14YmU6PsJVlDftJ0
         nh0zS3dJ/4Nd+eIuqwyvDZn1l5twwSxdaC/F9VzHgIFpu4TcywMVEtIl63V8nuXJCG6D
         pR8fgcYnmWmEv89dzCW2iZgmZ58vQwhnigxC3NjZg7RsHFUbtfBF0cwa0po0HyjKW3+k
         hwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=IniFjyVHQ6lWflzIsICmJ5JUtVB9MkE1WWkHF07cmBg=;
        b=jcINV8N8YhM4frcYvz45Hn7YbgmOtqneK9VWSEB9rpx1R2dOhpdQp5tfNzM0zGLXLQ
         td9tvsfmQpwIuxd5CUNkPZdGwmRFxnVaPtTEjbrJ2kNg0k0ET1gSd0IZzZezyxyygmGN
         GRb9hj0YHO8+t/GjA3uqy/LnXvRIcYS3/UkNp2I9LIGCvKwdpbgROllwbCMILTnd+Bbf
         HB80qlIf6cmhICDeeD7OEB9mgk079Rxl+40+wd6W3VZ/oifcZZypoyZh/jusA6kJe7R1
         sWpOEXO4D5sh7klqML6vuvSDFVCvhfCts8USYZjNsTesA4t7QwP0oLws0N6LQc5JUB6t
         B77w==
X-Gm-Message-State: ACgBeo3uSxHTxXM5WOWk1M/T2JdjnUeOIIgIpTCPxfYvEWRxqpWDZU8W
        ulJJFIWLW5qON04Ya7MbrVf/6U3z8D/yPx0QprM=
X-Google-Smtp-Source: AA6agR7HkYAHKHn5thK+ilpT1CJCpvbSylmARS6oxhltDAHcuvAwzKZjyNzusXacxYeILgXiPd7ULwgjhy6VRv3yqdY=
X-Received: by 2002:a0d:d883:0:b0:324:e4fe:9cd3 with SMTP id
 a125-20020a0dd883000000b00324e4fe9cd3mr7532355ywe.495.1659408475578; Mon, 01
 Aug 2022 19:47:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6900:ac9:0:0:0:0 with HTTP; Mon, 1 Aug 2022 19:47:55
 -0700 (PDT)
Reply-To: usdepartmenttreasury63@gmail.com
From:   "U.S DEPARTMENT TREASURY" <boiatoaka@gmail.com>
Date:   Tue, 2 Aug 2022 02:47:55 +0000
Message-ID: <CADjH9KjM8k+cTEsRJvYvCHbokYrAPO=ia-3ZQ0F0x-KuPYOcuQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,

You have an important message get back to me for more information.

Mr. Marcus Hamlin
Deputy U.S. Department of the Treasury
