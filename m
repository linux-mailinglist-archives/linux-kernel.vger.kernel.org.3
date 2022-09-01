Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D915A8DF2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 08:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbiIAGEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 02:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbiIAGEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 02:04:36 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549D1E2C67
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 23:04:36 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id e7so7396115ilc.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 23:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=P0KFx8ZyOrHcngCKqgKagANWqMLi9s905+GAobwWs4f5I4VrgI1al3bO1zeubB+tTs
         3TnGGNRzhpsy/YwEzsU4NlG6xx4AF0P9kYS3336w7oJz2XrdukgZiMST+OaqdqoXqz3K
         9q3Sp/og3VznjYZ5IFlPDTVo1vTTH4/HKShxAe1yYHmRjZkkUcP4bcfUazESyP4kiBRt
         1N/Hptfn060VLDmSz/LJsppb2AWPbxVTkDIIn41iWKOm3ZpCA4jS918xbG8K8TgpvMm9
         kjLxcy+m1DEdvxRGhxSRjpHvUnEW4BTEt+lowbHwaXhIqF/h9C/n9cpKTCaRsC7uuxkW
         yxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=yqS6/k9DU+oAX8zuj3TBOmTARr4b/ikmREt4w4U1iyxBWJnUxbzXHDUl/1jOfttjdO
         ZRUYgoAfz33zhLx7pTF1mk6k//BOsWBm+kNl7OixY/qhiqnGZUoues3cKamF8GANf19H
         LUSp5rROv16AKxsOCI37iASllzjcPMmkaKQcKFdIOJF6eWjoyb2BJd1kEO0YqvdsSwjZ
         Lfa7EtEP+vN2A8Tb9DRqZFGOjCo6SDNP8s2+8Z/fC380yRx0dmGFOVrcQluqL05URXqc
         t5S7QTKTmkbu1Iqo3wD9juj6u7AMmCwH9W0keCJn3qDiOFlEmlRXTjx0L7UU8EuIQ19J
         YLOw==
X-Gm-Message-State: ACgBeo2kjC/OwrrDtCzZRMFhQQg5XkS3aUsVT44JqRxypNEjEVwXzEKK
        7r+YE+1XgpaZEwo5tgWp/JvueJ9ermSBgr3iQOQ=
X-Google-Smtp-Source: AA6agR5moLVWYPJj5wDxZVbQ6gSSfsXAY5YjLuBw5LO52HPdOlmsHvXPl7wW4lVab+FGyalQOJAJQO8P81UhqgR/ls4=
X-Received: by 2002:a05:6e02:543:b0:2eb:5d3c:dde6 with SMTP id
 i3-20020a056e02054300b002eb5d3cdde6mr5040480ils.84.1662012275751; Wed, 31 Aug
 2022 23:04:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:29c8:0:b0:349:d3f5:d804 with HTTP; Wed, 31 Aug 2022
 23:04:35 -0700 (PDT)
Reply-To: maryalbert00045@gmail.com
From:   Mary Albert <tinaevan26261@gmail.com>
Date:   Thu, 1 Sep 2022 07:04:35 +0100
Message-ID: <CAD13F+W9qGrUP5nptSW7KyY9LH3Bixd-Q9W-jsMWLu8vAUMM7A@mail.gmail.com>
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
        *      [2607:f8b0:4864:20:0:0:0:141 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4882]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [maryalbert00045[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [tinaevan26261[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [tinaevan26261[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
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

-- 
Hello,
how are you?
