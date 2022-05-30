Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2534F537A90
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 14:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbiE3MVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 08:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbiE3MVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 08:21:36 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F006D13E9F
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 05:21:34 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id p22so16423014lfo.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 05:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mNQ+U40v4Jk5THQMAQ35qlnMd3rHPzax0ZnEhguyVkE=;
        b=LHC5z84Cd6j89MIKVT3vngrpXNRy3R+8ACcaYb8qpwj1xexi2L8cEUSMMqq+8LxPZ+
         aJGUVmJ4/tyxqOA+NpMLXMzyhcXrMN2uU8ThFnlG8XEQyS3AT6VnbxdSYhlklxvLi1MH
         HLMhVB79ltm6z9HHKhiT9IYHBIPmayL2NKbhbltBwBTSZzeGH45TsKmETyz7SIgnby2h
         vVtqmW68EnUKkp6bBG8QkbDbAcC7P9HDaKIpSLk31yuaKTWo5Ue0PufxtrnDJ+ALozBc
         P9Xeja4FbeRODAdS+KaVj4zraU/4qFPtJfmN7bjhTdc5QHiHq91MQc8z6rydVJT1IFLl
         e0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=mNQ+U40v4Jk5THQMAQ35qlnMd3rHPzax0ZnEhguyVkE=;
        b=ChGzZbqTkA82/VL8XaNAg8t0c4x8JktE7KFhJMqfSDtVncVQpqLjsKFFIZTivLmuBp
         lrC61iwugpjvYaUsmhDJJG/41Nkeh9lDoZbpgKG4Kuy4BJgQ1IG4TkIfnUdaVPHEF3WW
         SQy1r2V+N4eGNyHQUbx2KvGVWejK5QPNCfIusICu4FxxAKNkJpE2Op7mnFVouz1Lez0O
         SHoqANp/HzFdGWicLf1h5wr5eBLoa11HSScXMWR+1jrVuYDEgYcbQZY6prMP/k6/S/WF
         FzxinEHR1tl15MjPxvax1Tu9Nwa3JPE4hA9Zbd5xcAV8sjQKQ0h5FepHNc6vRuRWYqTq
         DooQ==
X-Gm-Message-State: AOAM530KJ42y+3fII0ktzoVNKEk6hxr1G6aLQWH4KQ6fgDcYpSoa/zbW
        yDWGxkbsaoOphOr+E94xu7LKytXLitnXfSXBo1o=
X-Google-Smtp-Source: ABdhPJy8pYMrtwvTkNb8ZVYcV+jsyq5DUafOz/tgC9zpRZxMO80viiCZGqMUYnIAOpgiSVU/98tpJyZnTe9XaHdHO48=
X-Received: by 2002:a05:6512:2806:b0:478:54db:fa23 with SMTP id
 cf6-20020a056512280600b0047854dbfa23mr34988397lfb.253.1653913292986; Mon, 30
 May 2022 05:21:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6512:c14:0:0:0:0 with HTTP; Mon, 30 May 2022 05:21:32
 -0700 (PDT)
Reply-To: edwinsschultz@gmail.com
From:   Edwin Schultz <vanesabrook@gmail.com>
Date:   Mon, 30 May 2022 13:21:32 +0100
Message-ID: <CAFtSaVs0t+iV9gmfJtugi4=rvMqqMr0TTU1+CXQWYC5sCaFX=g@mail.gmail.com>
Subject: Greetings!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings! I=E2=80=99m a Research Assistant of my Company and I have a proj=
ect offer.

My regards
Edwin Schultz
