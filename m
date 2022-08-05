Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3821858AA07
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 13:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237779AbiHELTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 07:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237897AbiHELTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 07:19:22 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F8565815
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 04:19:21 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-31f41584236so21211157b3.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 04:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=muUdW2iF3NLjwFcKkUArmJmVBNuXYz5InLqAh5elhfQ=;
        b=PBodHE7kki145FTZixnG2EtB/k6IXOGcZbPII4aVnWg8c5SAeYspb+V9eep8AdQsz5
         xArW2f6Ewzajstb9X4c3FegWotxUL4bMQQn9RyYEFQy4VUPYEjxwotX4oGNNbOYY913U
         A/jkGK/CuQIynkn9L2nRv1ZI1xFTZd2ns5nhAHoDixS5EudUU6GFv7IqpT6B2Krpx7tr
         9Dr3QzvCc4H6ECDXT/iuII+hbM6xjST/EHCKRQ5hgK2dRc0/Fcpf83itLcP+PUVyvH8B
         b+AoDRmnh8m2p4jHj/4KLNAxV6WwfzZHoF4mY26w5tGFaUiqvHNcltd1uA3FYS4Wo5Ky
         1qZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=muUdW2iF3NLjwFcKkUArmJmVBNuXYz5InLqAh5elhfQ=;
        b=vRw/rXdMsfFSB2RiRYG/RgE4CTa9/BNBSBfho7IIzJ/KcKQaecdA+3Hcst+Cqlw7W9
         6kkARtI2bxHrKuivI4BNeDQ4x1nWwohOxrP0qFf7SOK41s26wLiQiUTtNOdTd8acs4nm
         kfKNENOdjRu7/6dmQ0WWVBEtYs1AAfK22WFAc3OYPIwfC1zk+wzbgDMC2EIut8n0IXAq
         VSbytVRUBjvUoT9WFBi3S/czGcjPinvqoRq99klxDRlutSKFnnxMf/HdACBxv0SjJsdb
         ff1hib2uPSLZjh3eO6VWoQ7dHDyY1Ocphm/M0Oyo54XhTW+7u+LgcAYuaN5kEuMl/a1Z
         lD7Q==
X-Gm-Message-State: ACgBeo1CUmltEwPHgWegV+qoSD6VSBMfnP50lsdQ8xQTQBiS/8MWOJpI
        2rtTe7FzXOTHsIJpcYD89WAcTzP61iZW+MTjXkg=
X-Google-Smtp-Source: AA6agR41M5mLY/QdCwfAI/uDCahVTdVzTM8cETxCV7hflzDidVXmxgV3iS/jg1HozIVcY+Sd/OvLZY6jq/+lrmFiQss=
X-Received: by 2002:a81:3946:0:b0:324:9866:832e with SMTP id
 g67-20020a813946000000b003249866832emr5721746ywa.35.1659698360671; Fri, 05
 Aug 2022 04:19:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:5087:b0:2e8:760f:3500 with HTTP; Fri, 5 Aug 2022
 04:19:20 -0700 (PDT)
Reply-To: rolandnyemih200@gmail.com
From:   Rowland Nyemih <fralaimetals100@gmail.com>
Date:   Fri, 5 Aug 2022 12:19:20 +0100
Message-ID: <CA+5KX23AR5NAsfDwrrjrAv3p1Vc-feP5QU-VDD5JBVGLzX=WcA@mail.gmail.com>
Subject: Rowland
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1133 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [fralaimetals100[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [fralaimetals100[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [rolandnyemih200[at]gmail.com]
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

HI,
Good day.
Kindly confirm to me if this is your correct email Address and get
back to me for our interest.
Sincerely,
Rowland Nyemih
