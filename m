Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D84454D62F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 02:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347138AbiFPAg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 20:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235816AbiFPAg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 20:36:27 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05B757120
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:36:26 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 123so12881549pgb.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 17:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=ZEFyTkrnZxq7Uo9pryM4aB5D0J2velWBGzme7s4VbM4Dh+OSRgLY2mR0C8MoNqK7Sz
         gPcLjhXOY2PX72jOm5p2iEgz3fhhRUDkmARY4hDe9EGtdx6kIdSCMDOQD46m6vdHHRpc
         cTZqIEpHmXp4AqY1tHpwaerizjZB8mfWQgsdUGE8jWs0C4lf/0DMMs9rK2o/jYuHA0R3
         RwrOAUKN0WhtYGKlE0cBvyHVmjtg8nbH/ipRLRedt+zEpG4appxX4FjOZWNikXj6v6q4
         HBuUQYkSoVnKXoZ7VyudiETwA0WYSWQwIyI3LJpSiA8jfQf+B5mxEkF3iqxlE9nQ9hJk
         uhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=0zKskQAZKIoH0WMVZpLk3aA1qk1ZWWIWZDOsS4xAWETD/AkO/6FDWoobOC+DoaaF0h
         hSU6xRvuZiqd+dbEiDnNWL8BlewJ+36R9400pRjLW1XFIRtjWjpXtq+WrW1YS581GyCW
         /WnzUbI87eCO5/16nWLkxz4ZM3u57dhGMlHSNMyDq8LQbIGlkFHmL8vtWT5mYHL4w8q7
         cEGP9qRKrtamvb86PMszmHhRbNMhumpJWTvyWP87zB90r7jG6PzUuORgeBLmDNJOxPZ1
         nVomtTpFieyWVHXxzuXJhFdSKJpsr7llLTECIU41vYbzeJmijNUObJLrza81m3PgNJJB
         tUuA==
X-Gm-Message-State: AJIora/f7Cx2NUKVppkecPr9Wo0x1lNGThIX/9zL6+yOCPnxC4Y/O/IW
        rQ6bGcAy4gxhW4lUChTDNJ+x5VUtKbQPMB2bDC5jMFdw2eaOGXss
X-Google-Smtp-Source: AGRyM1sXBdpCndowWBdoIyf/Tk/10XdrGD0ZuqZNRW0tDkt2a34JoWNgw8xizJRgycoA9bLVLiJcp448kYwR/CBJSJk=
X-Received: by 2002:a63:5709:0:b0:401:b6bc:18aa with SMTP id
 l9-20020a635709000000b00401b6bc18aamr2085666pgb.161.1655339775366; Wed, 15
 Jun 2022 17:36:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a06:116:b0:4e2:207c:83df with HTTP; Wed, 15 Jun 2022
 17:36:14 -0700 (PDT)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <tracywilliam26@gmail.com>
Date:   Wed, 15 Jun 2022 17:36:14 -0700
Message-ID: <CAKhG-80ZepPv51Ca98EbX9Hi5PfT5-pxppzYHFT7pfGBQ3a4oQ@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
