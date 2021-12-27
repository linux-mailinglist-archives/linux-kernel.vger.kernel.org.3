Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82CC47F997
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 01:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbhL0Aph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 19:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbhL0Apg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 19:45:36 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B21C06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 16:45:36 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id q3so8093230pfs.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 16:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Av10FJHZ16PNlaWBwLeHhLYMKvHi/4lm87heoggNDKA=;
        b=oOSq+GjBoSdfv7+Xf5V6QrHa9oUDqNmDk0WnAugOOETZ6vrRW4MvD0vME+OEcSy/Ti
         /dNekzYIztxiuGt6d/+q1JLrbHHnPs7hya4XwCdCwcrKEczRNg3a29FFG83XRYAYOgeL
         AJlCaAqxSlhgwB+dL7gciFtoIBjby41dCDhOjL4LBjsTsjawAfShQee0n4qulOYhuagj
         E+Vy8vABakfVaa4whn7Lo0MZi/NZljeZ/5Pz7Fsz7kBll5s1ME/pELhTCkfuAYXYeVZ1
         naL03br52HkAL7pbQXfRjbKtcBZdcSlCWB0w9QpZWQIvhaH117+Ck3boaqmrLJ9IxpRs
         qe7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Av10FJHZ16PNlaWBwLeHhLYMKvHi/4lm87heoggNDKA=;
        b=XQtXBmMjyDNGDeuTwXC5id/ltuvkjNPGHWBw8a6fBSQ2cn4DegKlQMX2yERVZPwfl2
         Krp4IbBk9UZMSZ/MMGWQQc35pQFiXz+PKtXr7Vh7APLwT5utojCFkpNLB04ZNGzyuuiJ
         UFnn5YuBAOrVRR2sgFlDIt89dDB4GRvvS/1itzeIKPkdxK53WMFUDjodIVL70rjcOtnm
         xkbZCr2phMYgLwwKKVogMnz4qk1ROn6IbzFV26kXtw3jo8rylnfPTsaLrmjpQPUwMSTq
         lr4h7NGfPLLFaZGTPvEOW2gKLxX9hM0BIxCKU4/SSI1IN+7rkdRnzCxmfHhKftPVV+2G
         j4Gg==
X-Gm-Message-State: AOAM532JIpfm6QJiXCYPgYuwG/NTyZtXYcRX5BJG1p2p2qEx47mHn+yW
        zY/g1pJowBX//PXT7dM7Sbh1qWEUjdrcx5D+5GE=
X-Google-Smtp-Source: ABdhPJwEmIvJiP81mZ8mILblF8Jm0dHEAEPxqAQ/Xb64JVEB7JnOpBvUp3FWle9ATx+OylVMbpadh6SqlwvRtGSVXtI=
X-Received: by 2002:a63:6cc8:: with SMTP id h191mr13692166pgc.76.1640565935704;
 Sun, 26 Dec 2021 16:45:35 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:4102:0:0:0:0 with HTTP; Sun, 26 Dec 2021 16:45:35
 -0800 (PST)
Reply-To: fionahill.usa@hotmail.com
From:   Fiona Hill <grace.desmond2021@gmail.com>
Date:   Sun, 26 Dec 2021 16:45:35 -0800
Message-ID: <CAOW9D1t8qfZwWYhh0=L1=t8FFS4xVf5b=R0_--WjnR6269DMDQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hi, did you receive my message  i send to you?
