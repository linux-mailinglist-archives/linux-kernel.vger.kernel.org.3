Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27ACD484FE9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238807AbiAEJTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238797AbiAEJTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:19:46 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6A7C061761
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 01:19:46 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id c14-20020a17090a674e00b001b31e16749cso1579409pjm.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 01:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x4xfp6CvEJH53YpVF7NoIR4W7WJmaRDYx9TOiF5fZvk=;
        b=hpgqSlVhHzheocyTxliAFBenwRbXXtn/vLmf7R6E8UjVL6rkdw5vRvCnwc0eJCvuVh
         HGm9CkWzytc72qPU1i3GEK01rZi7ciuxC1wmcUqKsjPrwERjvZZ5EvrtIYcRXjkLys3n
         Bog9A065LdqlIPuXKPbu8+UZ4GNIJcx5+NrPL8dbnRRi/gD/OZ+aPwUk6hemCJj0NctZ
         b3FmikZiqopjZEN2l+bkkwcAZCQxYiFwstkZ8oZYBfI0D/rwDY6ToT28wadT9iYk2aBd
         aoB22AbjBulzFuhhZGzV2ZmaSBIou6DTxPRhwz9DDprg2yk8WGZ6WAAXBdKzpK+dzDtV
         9xmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x4xfp6CvEJH53YpVF7NoIR4W7WJmaRDYx9TOiF5fZvk=;
        b=NCi4Pq+5YkRk9Yc5/jS2u9CSFL2CGytBHWy6KM6/5u/8ETeB7uPnzPxZnRd3aLJnNb
         a97XeXLYw+wmOfawRxtJfpAvdqKEPZiZkNa6uRiRNP0P+EJAg07PzxpKAPTi37ZkTMSi
         gkmc0kcTgfLCSkffexjGHNjX02Mp4KK5jL+ls9kJYvhvW7t3dNSKZX/iHwCTcwv1Huxh
         g4QJe3nby8k//r9xe0Id/RgHm+S/M7be2MmoTirWQ7TxZP5vQ2beLOwELwt0Bd9Im+Xh
         nWyjoJ69+siPFV8rHKYFwiPywTPlrGT6bo5k/w69C5ZUo54A9CdB7AmgQGN+cm1749VB
         UO6Q==
X-Gm-Message-State: AOAM533UQX4wMTzNnJLk/dWkuiH2loCjpJLFTVJHx4GXlU0HOIuMgivL
        aIk6Ub+6qKLd9UFQMEMXKQI=
X-Google-Smtp-Source: ABdhPJzLEEXLL8K9wrcKraZT/RQRDvdThvUaUCkZZsdkC3uuvABqPAL7xsnY+YB76jHQ5p+npWPh+g==
X-Received: by 2002:a17:902:e749:b0:148:f083:3905 with SMTP id p9-20020a170902e74900b00148f0833905mr53325365plf.136.1641374386233;
        Wed, 05 Jan 2022 01:19:46 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x25sm41196293pfu.8.2022.01.05.01.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 01:19:46 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     gregkh@linuxfoundation.org
Cc:     arve@android.com, cgel.zte@gmail.com, chi.minghao@zte.com.cn,
        christian@brauner.io, hridya@google.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com,
        tkjos@android.com, zealci@zte.com.cn
Subject: 'Re: [PATCH] drivers/android: remove redundant ret variable'
Date:   Wed,  5 Jan 2022 09:19:42 +0000
Message-Id: <20220105091942.616961-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YdQzNX77nT2OIh7W@kroah.com>
References: <YdQzNX77nT2OIh7W@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found that there are indeed some optimizations
after removing the redundancy.

For example:

int foo(int a, int b)
{
        int ret;
        ret = a>b ? a: b;
        return ret;
}
int main()
{
        int val;
        val = foo(7,2);
        return 0;
}

and

int foo(int a, int b)
{
        return a>b ? a: b;
}
int main()
{
        int val;
        val = foo(7,2);
        return 0;
}

The corresponding disassembly code is as follows：

    1129:       f3 0f 1e fa             endbr64 
    112d:       55                      push   %rbp
    112e:       48 89 e5                mov    %rsp,%rbp
    1131:       89 7d fc                mov    %edi,-0x4(%rbp)
    1134:       89 75 f8                mov    %esi,-0x8(%rbp)
    1137:       8b 45 fc                mov    -0x4(%rbp),%eax
    113a:       39 45 f8                cmp    %eax,-0x8(%rbp)
    113d:       0f 4d 45 f8             cmovge -0x8(%rbp),%eax
    1141:       5d                      pop    %rbp
    1142:       c3                      retq

and

    1129:       f3 0f 1e fa             endbr64 
    112d:       55                      push   %rbp
    112e:       48 89 e5                mov    %rsp,%rbp
    1131:       89 7d ec                mov    %edi,-0x14(%rbp)
    1134:       89 75 e8                mov    %esi,-0x18(%rbp)
    1137:       8b 45 ec                mov    -0x14(%rbp),%eax
    113a:       39 45 e8                cmp    %eax,-0x18(%rbp)
    113d:       0f 4d 45 e8             cmovge -0x18(%rbp),%eax
    1141:       89 45 fc                mov    %eax,-0x4(%rbp)
    1144:       8b 45 fc                mov    -0x4(%rbp),%eax
    1147:       5d                      pop    %rbp
    1148:       c3                      retq

After removing the redundancy, the compiler does
have some optimizations

