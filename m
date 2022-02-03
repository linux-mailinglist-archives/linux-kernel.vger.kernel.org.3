Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADC74A7CBE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 01:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348477AbiBCAVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 19:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbiBCAVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 19:21:41 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE40C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 16:21:41 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o64so890271pjo.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 16:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=5c08idIbIPlUpn1GNo+KqjI3Qx1uZqYyH7BIwKLaytA=;
        b=NOap1tWdv3bZDouDePX7WIAYCKBVAq/2HUiS+sdDnqo6QU9e4x/y9itKxxfyl4acOd
         N9nQh/pOMD+/RD61D6ermuELgWYxcf7zDhKoBTQqkh9CTKNDzT4Gtu2VPDj9DZALeOUZ
         G/GOatS7rUpFmgH8Ff2bEPKcNL7i+J/add0KDSwO2E8WbBRSyhtE1wGNpxoRmoWPFdBr
         j15sAbtFrANzDNXptsEFzFu/mK9Ib/zp7UCe0wQ1RSEdsgeEB55++ZAxcj67l+2J04hd
         KSxuj+xSSf7TMp0DSGiZxPNgChhMCwTChb+hGvGdtq9cbzCJ7D/H661vuxPuaDTknNvE
         Xf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=5c08idIbIPlUpn1GNo+KqjI3Qx1uZqYyH7BIwKLaytA=;
        b=6OuquwGqsg96uer4OSYY98bu+KdHH6OlpRLbuw0sr+7ETV2paSQz28NpI+27aVL+Fv
         hTA8JweE4+i/fmakBAl6+T86nW5Y96kONmjVpgknZKS3Xc4Q64Z7eJWkt8O+xypTy1x7
         7tkZGDYwjVco3uz4DCVA2o4/zTujKBOdZZTxXCAI1ukgMrKx8f911VIvRqrBuXTpsmfh
         /Zuq57C8MMOhN9XsSCIVZsLuVM9Zpr00RWCO7655EVQrDZEhNZq5jpoZ8gtPRThTswkA
         uLOZOpHWKfaL1Y0Ab2EZ+R+K4TlfFrfNuT2a2kwrSGExqyu1RAdT1/UMJSloMmi3Vmyj
         hfSQ==
X-Gm-Message-State: AOAM530YA43fFXRyA9wnzezB2tYIkz9lvLiFqTxVXH0ZJZlCByl4ziUM
        Ukx1X+w7hICV8q59zD63tjOAsw53XJA=
X-Google-Smtp-Source: ABdhPJz0+9/m3xsV3/vedvQaQuiRg+lD3fwMFNzZif3fkTsvejoz+gbtL1bH/akphXML9YxyfBa+FQ==
X-Received: by 2002:a17:902:a9c5:: with SMTP id b5mr33090254plr.167.1643847700367;
        Wed, 02 Feb 2022 16:21:40 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id a71sm3945659pge.12.2022.02.02.16.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 16:21:39 -0800 (PST)
Message-ID: <fbad2233-207e-6b66-890b-ef1b1f97fdad@gmail.com>
Date:   Wed, 2 Feb 2022 16:21:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Doug Berger <opendmb@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        SeongJae Park <sj@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Updated git tree for MM patches??
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Johannes,

The MAINTAINERS file for MEMORY MANAGEMENT lists the following git tree:

git://github.com/hnaz/linux-mm.git

however it does not look like it has been updated in the past 5 months 
or so as master still points to 5.17-rc7-mm1

Is there another git tree that other memory management related 
subsystems use for development?

Thanks!
-- 
Florian
