Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355CE572E58
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbiGMGmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiGMGmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:42:17 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124D8DE1A7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 23:42:17 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id g4so9662457pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 23:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=HzERyUX8r42O7EeoFdBNAgcejWeBbz5fOTEqqjH+TQQ=;
        b=UT72qyLSZTrNN2pPbYlxDZHIt0TY7vGtUxtCTRLe5e0vEmuHSDaSboOiXm9eEcuiS7
         s0WvG7aHhKjCHb/xn4qrj47u5jfgEJ7UFLbn1AYZgauI23jEN57NQMrG0lPl1zc3aclP
         tmEhMqhfvyyjwBKZeAhk0SSb/HXSsE+GimnSqdEVNWToPnsaIKHP2Blz1jYDBKnSQmwZ
         XpMu6F5XG9VeIcPNLW+mCccOi1omNDQAeSGYP7Jk+dJ3f9LX3scil2ZBDEituPlKJbUI
         FwdqEXsUoCIWqKVlWHtV37m/BWrbUJt1cu0r+yU0g6LW6gILdkMLDiaYrbjlbK+wmtpF
         UL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=HzERyUX8r42O7EeoFdBNAgcejWeBbz5fOTEqqjH+TQQ=;
        b=O8z7aAnShUqmpuTwOyoS8LKK5qDyE88UpijPhRY5HcOdh2BUFIfbr1VDyZUvVt6Opo
         fnwTvo6DiddzVgH+/nNRJdazH+S8xP8Ps5lNTM0oezoi5NCSQ+M+oI5sWw5tugJPxTe8
         LVwS9SlOv8csoNwXlSdzBoi5rxKHuq5BIuS+afzvN4zsX3XZ91TN9jJQEqJVh95c4dBF
         PZJCPBGALWnZCO9f7rqh+/PsjQXltnLxA1znv06+PYzqZpbEGkpVCrMFe2LVA98xbpfw
         nMP5MR1fBoDjcCAtmZr0ZSCEObCu9oG2f614nTVA4OaOLvKU4YUobXY+QUXMywI4YVnE
         UKXw==
X-Gm-Message-State: AJIora/MjjlrDJ8oP3CJnA7rRcuD2A5rKyFOogsIWWUjSB+AwuTHQnFf
        TlGHPpkY5odxZqwJeTn2u0vsX8DLqljyRlGQ
X-Google-Smtp-Source: AGRyM1s5JTP58vkFg4ZOzYsjyYwvU5vCEwBwoiCMvXMn+O/ixwKG0a5JqRypQMu37KDrrWbcxg9EWA==
X-Received: by 2002:a63:d1e:0:b0:40d:379e:bff8 with SMTP id c30-20020a630d1e000000b0040d379ebff8mr1782207pgl.215.1657694536487;
        Tue, 12 Jul 2022 23:42:16 -0700 (PDT)
Received: from MBP ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id h27-20020aa79f5b000000b005251fff13dfsm7980873pfr.155.2022.07.12.23.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 23:42:15 -0700 (PDT)
References: <20220707090501.55483-1-schspa@gmail.com>
 <Ys4zVkJCH04cnSGX@xsang-OptiPlex-9020>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Schspa Shi <schspa@gmail.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com,
        guobing.chen@intel.com, ming.a.chen@intel.com, frank.du@intel.com,
        Shuhua.Fan@intel.com, wangyang.guo@intel.com,
        Wenhuan.Huang@intel.com, jessica.ji@intel.com, shan.kang@intel.com,
        guangli.li@intel.com, tiejun.li@intel.com, yu.ma@intel.com,
        dapeng1.mi@intel.com, jiebin.sun@intel.com, gengxin.xie@intel.com,
        fan.zhao@intel.com, tj@kernel.org, jiangshanlai@gmail.com
Subject: Re: [workqueue]  1a0a67f5ef:
 phoronix-test-suite.fio.SequentialRead.IO_uring.Yes.No.1MB.DefaultTestDirectory.mb_s
 -17.7% regression
Date:   Wed, 13 Jul 2022 14:09:28 +0800
In-reply-to: <Ys4zVkJCH04cnSGX@xsang-OptiPlex-9020>
Message-ID: <m2bkttms3w.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


kernel test robot <oliver.sang@intel.com> writes:

> Greeting,
>
> FYI, we noticed a -17.7% regression of phoronix-test-suite.fio.SequentialRead.IO_uring.Yes.No.1MB.DefaultTestDirectory.mb_s due to commit:
>

This performance drop can be fixed by convert to wq_pool_attach_mutex
to a rwsem, or add another lock for this. I will upload a new PATCH
version for this.

-- 
BRs
Schspa Shi
