Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4217517310
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 17:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385967AbiEBPow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 11:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384180AbiEBPos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:44:48 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8BEB92
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 08:41:19 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id be20so17045381edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 08:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=kdTSJmnbBK4N/virhew8A7fzQDKu0iWJnLEnGHSX4Dw=;
        b=LiDnLEt9mMDcOUqe/y+G7PLlyLQ2PDwgp6TDpNZqUbbnzLevTkk2hqa5oP4qOkhVZp
         TZF69jYA8rlqeLHQolaHiJaBRX/gD8RbJZVtnj/1DrQ/baBCHIkhL3Zj5Zjpu8yV6Hwn
         SGZdKypbE7W780qgiJ+fz67GeKkj0J2r73jmahViqDnzjpSy8W1Vt13nv59wLr7o0r3b
         zAdKAg4Qt6/WeKUbNfDIwug7M7j0sUaGfE4tQ/SMylmac3l7OPaxBSxuZWbrQ/tHvNXA
         eRfhV1Np33vY302pf5LvB2W2zuBa0uYt3+zpoYWMWtBGmNX8ALOtqIalGGhM8BTu7Evv
         BH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=kdTSJmnbBK4N/virhew8A7fzQDKu0iWJnLEnGHSX4Dw=;
        b=wHcb5TUk7CW192DbnyzZ0NWbk6uMeemC04uzfN2ap+OIu+RqawiHPKM8AZUyiQuBgR
         zKyMAYUGaVhRpuITd5Jd2SJKwgSYD1HKWgFkuuUsba0mz2FVtpCuHY9OvKbOPvT+nFDx
         MTOD0js3XRbIm+8pq4/sSZJM2MxYbxuO/FHfdIQDSFipQo2TXUfe1BQIWDQiMsnFuW/j
         +S/sdvQZaWhKGLLWnuAyJmDz54bOqMe8n9PKOML4weh1kk7sBAs+43/feCtkeB0UJ8TZ
         Jk2/DE1pvLGnQRy211tpTknvgqFzae7YR2xSxn6mmnKrD+O9lxuk4OK8PZbHlmqWHWYE
         taNg==
X-Gm-Message-State: AOAM532q4FF7jy6L266tXy/WE+7yah4Kvy0j4z5Muwv9X1o/L6jMbPxK
        ZWsLwdPErgMHqNh2DkC4kUyK4DFSf+VhND5hQQTo03TpWb0=
X-Google-Smtp-Source: ABdhPJxQnoPAmGDkrnWenR9mItq06e4ef1D3WBimAj2Hf0fi9PpGTmNe2mQQ/IajB0EwH90WPecfV26+ZZYtEIqZSp8=
X-Received: by 2002:a05:6512:2398:b0:473:9cf5:1750 with SMTP id
 c24-20020a056512239800b004739cf51750mr3834545lfv.300.1651506066453; Mon, 02
 May 2022 08:41:06 -0700 (PDT)
MIME-Version: 1.0
Sender: arunadogbe@gmail.com
Received: by 2002:a05:6512:22c5:0:0:0:0 with HTTP; Mon, 2 May 2022 08:41:05
 -0700 (PDT)
From:   Lisa Williams <lw4666555@gmail.com>
Date:   Mon, 2 May 2022 16:41:05 +0100
X-Google-Sender-Auth: Us32P7O15QDQmfhDpX_dAhvk4jw
Message-ID: <CAPsVOGzyJPMeju17bbvX5hTyTOHJGABCr0Oy1WjZZxhKcxQcvQ@mail.gmail.com>
Subject: Hi Dear!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hi Dear

My name is Lisa Williams, I am from United States of America, Its my
pleasure to contact you for new and special friendship, I will be glad to
see your reply for us to know each other better

Yours
Lisa
