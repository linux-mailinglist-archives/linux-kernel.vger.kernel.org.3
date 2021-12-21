Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38F947BF1A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 12:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237252AbhLULsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 06:48:25 -0500
Received: from mailgw.kylinos.cn ([123.150.8.42]:41416 "EHLO nksmu.kylinos.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233650AbhLULsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 06:48:24 -0500
X-UUID: d9f9f3a06411479cbd6b91107b1a9251-20211221
X-CPASD-INFO: 72822263a5334c38b48f3febdbbd1d03@gIJyUl9kZGONVXV_g6Z-coJkZIaCqJ-
        ClJCSkFG5gn96Ul9sWVWEfWxUYGJgYVVzeW1ZaV5gXlF2fn91f1CFYmBcUJl6gI9rV2JmYg==
X-CPASD-FEATURE: 0.0
X-CLOUD-ID: 72822263a5334c38b48f3febdbbd1d03
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,EXT:0.0,OB:0.0,URL:-5,T
        VAL:156.0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:5.0,CUTS:7.0,IP:-2.0,MAL:0.0,ATTNUM:0.0
        ,PHF:-5.0,PHC:-5.0,SPF:4.0,EDMS:-3,IPLABEL:4488.0,FROMTO:0,AD:0,FFOB:0.0,CFOB
        :0.0,SPC:0.0,SIG:-5,AUF:100,DUF:27379,ACD:140,DCD:242,SL:0,AG:0,CFC:0.171,CFS
        R:0.996,UAT:0,RAF:1,VERSION:2.3.4
X-CPASD-ID: d9f9f3a06411479cbd6b91107b1a9251-20211221
X-CPASD-BLOCK: 0
X-CPASD-STAGE: 1, 1
X-UUID: d9f9f3a06411479cbd6b91107b1a9251-20211221
X-User: yinxiujiang@kylinos.cn
Received: from localhost.localdomain [(118.26.139.139)] by nksmu.kylinos.cn
        (envelope-from <yinxiujiang@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 541015439; Tue, 21 Dec 2021 20:00:59 +0800
From:   Yin Xiujiang <yinxiujiang@kylinos.cn>
To:     frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, erhard_f@mailbox.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Subject: Re: Fwd: [Bug 214867] New: UBSAN: shift-out-of-bounds in drivers/of/unittest.c:1933:36
Date:   Tue, 21 Dec 2021 19:48:17 +0800
Message-Id: <20211221114817.682347-1-yinxiujiang@kylinos.cn>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <c474a371-b524-1da8-4a67-e72cf8f2b0f7@gmail.com>
References: <c474a371-b524-1da8-4a67-e72cf8f2b0f7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think if you use unsigned, then 'id -= overlay_first_id' will not be 
less than 0 but will be a very large value and will be harder to judge.
