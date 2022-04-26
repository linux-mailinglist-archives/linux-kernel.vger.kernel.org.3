Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A32A50FBBA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 13:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349427AbiDZLNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 07:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349410AbiDZLNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:13:04 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D38B434AF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 04:09:56 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id r189so32295018ybr.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 04:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=y/WwzOufdV8bFjC2XhKxeIddPBCZMNKZVHLfMOMvj6I=;
        b=QbujpgPIUuywH+/6qjJZYPx9a6aUhUCEa4Fm0abS0vfFA+AZY0tyCDbin9c+JuKkwG
         rS6pAqn6u9zp/xD3cADRBAFLkZ+ugVEoitlp8fGWllj1+1SckQ2HOsdSq5nK06EBm2AI
         upK6AatQyY3A7TSXsH1e0DNTrEiUBBLeHneLB5v2nXlHde8QlBrWhhWSTiIetgo2LIIV
         9YIGfUs2LueLjOQdhPtvoxyGNKdbx9HspXUV5Mfn9POv1bbt57NGZdq/NuJ6A9432QBs
         19TU8C5ViKLdo7tKB7n+2hTHhyyYNlRHAjBsIOPyDtltufONCb65F8H9ItkclBx3RgGm
         W/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=y/WwzOufdV8bFjC2XhKxeIddPBCZMNKZVHLfMOMvj6I=;
        b=Zgb2sdQQfRyK94gvvVN+kiCsnrydlNVTQRfnAuvZWJZqUE3gczHzLoi+4ASxeW1lcZ
         MhtQyRsA4UrP2+idY8mL4mzFVD3wh0nEidyysk0NKg0uDz4HzOWrQBuQGEVrSmlVlfM8
         lf+qIHrC386t1jOoiP/DUtTvS6I0PZjUAwoZ3MRDBPi1Y9EPfXwRM5UteVSPvVekqc+e
         HFmg5a8o6K13r7xKbhZ7hQ0M3E/4Y/RTf5Eem77NFgS8AYob9D8/WEIPa0PUcZ4gYQSI
         iH8YpanqSaOa4yhvBhnHgc65hbOPLSoFcYw00zdyI6qMzUQowtRQpgJP4joNHaEzf9W/
         zuIw==
X-Gm-Message-State: AOAM533uo6BLSsCmtYHd1LuIo8oONRMB4Jg3KzekoXgXHCJQWrPx/kE+
        ff0sAycJE6XEEZ4X9M14CJ7mxvnUB6VXj83IabXyPQLCTSUlyqWK
X-Google-Smtp-Source: ABdhPJyAXBhGPkCqktSa/LBiGCKJVUKQQRDJWI6nHP880O2mXVDEQZzTVPYTB+34hrWtY/j1kHk+YIoMhs7E8wpFBNY=
X-Received: by 2002:a25:cc46:0:b0:645:d969:c0b6 with SMTP id
 l67-20020a25cc46000000b00645d969c0b6mr17962921ybf.245.1650971395355; Tue, 26
 Apr 2022 04:09:55 -0700 (PDT)
MIME-Version: 1.0
Reply-To: drtracywilliams89@gmail.com
Sender: mrblaisehonore2015@gmail.com
Received: by 2002:a05:7000:b80b:0:0:0:0 with HTTP; Tue, 26 Apr 2022 04:09:54
 -0700 (PDT)
From:   "Dr. Tracy Williams" <tracy0wiliams@gmail.com>
Date:   Tue, 26 Apr 2022 04:09:54 -0700
X-Google-Sender-Auth: E1y4vAoX3EsBenL6qw3Z2sNuBA0
Message-ID: <CAFGBUsgRkmmh6D=QyfODcGVkmL-UMLzMrnOkO+HPjvvO5eKRRw@mail.gmail.com>
Subject: From Dr. Tracy Williams.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b43 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrblaisehonore2015[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [drtracywilliams89[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mrblaisehonore2015[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear,

how are you today,I hope you are doing great. It is my great pleasure
to contact you,I want to make a new and special friend,I hope you
don't mind. My name is Tracy Williams

from the United States, Am a french and English nationality. I will
give you pictures and more details about my self as soon as i hear
from you in my email account bellow,
Here is my email address; drtracywilliams89@gmail.com


Please send your reply to my PRIVATE  mail box.
Thanks,

Tracy Williams.
