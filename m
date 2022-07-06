Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B1E568F9D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbiGFQsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbiGFQsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:48:31 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D838C29828
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 09:48:29 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id f14so4182912lfl.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 09:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=+3eISxlMF5FFS1REdRBVocHrvyFzFA/+/xEbkk9W6DA=;
        b=dnPRsZyU4F0G4723LzLfUdY5Ei++gnxPzF+3UNEi0gn4d0TOBmAX5/Md13KzjDAfmI
         fR99QphRKQL1HoEWFpnAqaNoQbliJukvqwP1mDuTMytye5TBRZAOuaHagkuONgBn0P6d
         PUTDOajVv5e/MH1QhpCOnj/LzlS3CSSB9thJ5sQubAAeXTt7c4izJweaVOpPENmXP51V
         P71/YsmzzMrOiBmYrfRB398D5yjE6BKrVXMwzHtaFOwfjA9/gBuKP7Vf/2WICoRo3sQ3
         jtbiILnGn8HbzIf46atFsZrA7KoLh2gdYRQnu6tLahTNZl9DQQ907FfMgUkc7bbrBi9H
         kWBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=+3eISxlMF5FFS1REdRBVocHrvyFzFA/+/xEbkk9W6DA=;
        b=WZIBimocbaZeGvCPPmmZLK30OoJtNCpLR+yoVq2m/KN+/6gkLG6p7+Ks3zktgI/t+r
         9gbUc2WI+NWQRXcXxRz38tWhkzsBJ3ZG78FrykiEmIGUkWLIHszGER8qQKXjX1xU6roo
         TUGB3uYsGnSZlZHCKcM80Gcm4MkNieZ4SxU+cygGhIa4oUsblgAWy/Q+HUHLgl2S/IrJ
         xxk4l+llH8xUoQ9JGHb/HQ9Tx/TCyOszdbKPwZSi0cp3W18KbzZrOmMxLAMyXvc+eyJd
         QAdXHlXhaSXoCPvRlQnLQh8QFcrhER0bLr5ftpyFbfGyhidHNC9fa1BMwHr50Z5BbTpG
         +5eA==
X-Gm-Message-State: AJIora8j/L1ofmUh0b+I3Hcv2Rx5C2A4eLaovhEFGtiuBJdReCQexWXL
        hydXLr54sh6uPSbMgFGLmdbjocTDRsWkxuwJrhA=
X-Google-Smtp-Source: AGRyM1tmzMf91Q81c4IL6I9c5db8isjrga0QU732GqxDGW6KQvxbjAWwgr8C3aJi15sAw6cn73t/LTzeHghlxDxWf1E=
X-Received: by 2002:a05:6512:3b0e:b0:482:a6ed:c4ed with SMTP id
 f14-20020a0565123b0e00b00482a6edc4edmr13199847lfv.123.1657126106924; Wed, 06
 Jul 2022 09:48:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6504:3164:b0:1cf:b677:7c31 with HTTP; Wed, 6 Jul 2022
 09:48:26 -0700 (PDT)
Reply-To: ulricamica000@outlook.com
From:   ulrica mica <chukwudiokorie38@gmail.com>
Date:   Wed, 6 Jul 2022 16:48:26 +0000
Message-ID: <CADJ1FuxH9cJ0RDfvb3+uuLoy0bfqH+S7GeVyJ49aqvw7zd023Q@mail.gmail.com>
Subject: re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear Good day to you

Can I talk to you please?

Mrs. Ulrica Mica

Best regards
