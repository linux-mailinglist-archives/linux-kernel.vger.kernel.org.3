Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEAB59AC89
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 10:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344342AbiHTIUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 04:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243060AbiHTIUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 04:20:10 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C697CB81E3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 01:20:08 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso5153973wma.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 01:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=LnQt4BR2X5OP5W6bgQb3WsaFGcLjpwJ/+eDdrDV+ugg=;
        b=q8FnnLLl+qYi/co3hyhKZRpjLXNzhXb/pzK0bpfU+dlCktVNbQkl1gjb5QcIwv/QeF
         yTX4qo2ZCJyFMTo47neK7K58fm/kjzMZU53gAJX8+oa2Iag02w9bn8TMtMYEV38x4qFR
         OfsnHTG1PLmXrKVFYw8JuBdTXa/xhyivA7x/YIcDQawCabHL5RViLofq7HRU5bBdWjHS
         tXWNYsCZ8DijFAJyctLMA5HqnldEPYXeIFPfEb+UOYxmLWswBppj4ox7b0UKDVfiJsqk
         JlejLFGDyJefFb3UUhiK84KCueK3lizhFgxOO/rGtPYn1BPfj2VzdsXyFzoIHTW50sD2
         D6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=LnQt4BR2X5OP5W6bgQb3WsaFGcLjpwJ/+eDdrDV+ugg=;
        b=dXl6Bewk8FJM5IPXq4kORKQcTAwCrBEs25DY3ckdnDaqmqW6/2s9i0IBxO5vrepkUF
         TiYjOjlI/0Km9AvOVZoj226DEogkWBySLeeIHZEQpQSiuTnNpVKIvmRIclQTYlya+OHa
         5Ws/bkKtPEawEQ8rZ8ji1HsoNSsZvFVWe9ZM3IicOohonvG1bvu2aEI2dVA6tw4oPDkL
         UqC2zR7aYRPMykKQVd8ckCy/vVGXawI3XCB8D/8QjyeuYBcaf8qRoR46ZuPjh+XhVRAl
         /lVdsMGbArGE8v1JqRdX64WmolnRVUgX1la3zCkXcFZST/iBSSJeOPm9waObfwlQKgWW
         7SDA==
X-Gm-Message-State: ACgBeo2P90G3TwjIGlsDJn9OJjCs1MKfz0t8OHXUBMJ3EEM0ibU/4e0p
        PfYXqGlhoAnEIfsUfcXjS1+pUJsOrE0pi4NbXOA=
X-Google-Smtp-Source: AA6agR5VFsHtWwOArvjEvgQA3y9UKxR/jP7I/QW+xYnuGc/5qZSi0wepBZVnCp9WT9CmV/GVhj4RJHKS1PRP6kw5dVE=
X-Received: by 2002:a7b:cb49:0:b0:3a6:544d:e248 with SMTP id
 v9-20020a7bcb49000000b003a6544de248mr57272wmj.125.1660983607290; Sat, 20 Aug
 2022 01:20:07 -0700 (PDT)
MIME-Version: 1.0
Sender: mrmohamadimiligo@gmail.com
Received: by 2002:a05:6000:1e0c:0:0:0:0 with HTTP; Sat, 20 Aug 2022 01:20:06
 -0700 (PDT)
From:   "Mrs. Samiratou Diasso" <mrssamiradiasso@gmail.com>
Date:   Sat, 20 Aug 2022 10:20:06 +0200
X-Google-Sender-Auth: cJ4tdcCKLr4PiFPL54XqsUktkTs
Message-ID: <CABLZky=zd_QjKv9yM40ZOEOXDimRQqXqwZhfbxkdBfmhKunkyw@mail.gmail.com>
Subject: I am counting on your sense of confidentiality.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        MILLION_HUNDRED,NA_DOLLARS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,
        URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Dear Friend,

How are you together with your family? I hope all is well.

I had the intent to contact you over transfer of fund worth the sum of
Five Million Three Hundred Thousand US Dollars. (US$5.3m) i agree that
45% of the total amount will be for you and 55% for me.

I need your urgent response on assurance of trust that you will not
deny my share when once the fund is transfer to your personal bank
account.

I look forward to hear from you immediately you receive this message,
upon receipt of your reply, i will give you full details on how the
business will be executed.

In sincerity,
Mrs. Samiratou DIASSO
