Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5D44C15CD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 15:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238201AbiBWOwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 09:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbiBWOwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 09:52:10 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC11145AD7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 06:51:41 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id bq11so23294193edb.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 06:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=cc9MqNMmRPnGn2jNc7Pps65gjZID7Zsj838zurhiU3RpQ1hviS1Qors8acteYzwE5/
         sVQwm1RhW2p+0lMpwc5138aCJ/arkBRgNuZBItqX1cnCV/GFT/FbQ5RTe3eLuCJ5azwJ
         gl3USkY/oQB+r24UyVHZ8stpxvVQ1hBfcAdZQPnIHanPjKglDWzr4Y1vv7oe1rPGCHhy
         +P4ZoUECS72mNSazRKgGfLzksQPQ3hianGB5AXc4ezEtcBjS/cN5rkCLFMZ+puHBaSSc
         QDPhuheObzxnfuXhgvo8vp+5oZkoU6x8Baa6GCVNkJm1Ufnro5ut3sibAj1A/EMo29tK
         19Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=IBryKnjgXKUmRcA8IWtHFWF7Ht41bb4aUYE71xVTqUTDZWFxlojF5VPTOXm/0zLkmh
         Adv8R1q909bDmolLHTXeQtVWTn5dtXKbyt4qfvLGOU8GaGha9X4/wIh1d8I043xEc6MO
         ElElBuEigoChPjG6Or8L9z99HPe5eH3d6+bbBbn7JU4UC+sfn2kTxEuLulYGdz5IARmH
         +vtK9MAloLIg2Mpu+zaCSVZYGJL6lSz4aKpVSSs/OzBK6+GG5narCfkKkFbhqZff5QM4
         qCk2OsCgXiZ57rzFeYxgKhghT4AlvK5RlUXhRVDIGzmRDO0T1JdTzh74sBuQUDC/zFjp
         TLHA==
X-Gm-Message-State: AOAM531HbSs4nxy2ftR80Y+sq0cjzaJEThzlZdOwgFcmRzSOSbzrBsGE
        /sf+4j+2I+2yZ64bJR2lQVwRQV6MiZOzPLT97qs=
X-Google-Smtp-Source: ABdhPJy9kNKhy0W1vTVANhBanBxz+2ZuiOK/eQxSbnYvSVYEvhXrniitLscasACW5Y3sEwASSotEBIFuXLTDoStFezc=
X-Received: by 2002:a50:c30a:0:b0:413:2ddb:b75 with SMTP id
 a10-20020a50c30a000000b004132ddb0b75mr4709337edb.19.1645627900098; Wed, 23
 Feb 2022 06:51:40 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6402:440d:0:0:0:0 with HTTP; Wed, 23 Feb 2022 06:51:39
 -0800 (PST)
Reply-To: avamedicinemed3@gmail.com
From:   Dr Ava Smith <tracywilliamusa@gmail.com>
Date:   Wed, 23 Feb 2022 06:51:39 -0800
Message-ID: <CAKU4NYmg4qt-Uk4ovetvcH3FDAYsfw2wiY-r5h_kjke_yz-Vdg@mail.gmail.com>
Subject: From Dr Ava Smith from United States
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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
