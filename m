Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDD34C3856
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbiBXWFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbiBXWFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:05:00 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1657D27FB83;
        Thu, 24 Feb 2022 14:04:29 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id qk11so7229659ejb.2;
        Thu, 24 Feb 2022 14:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yTo2AJFj0p024dmFgNzjlTjj1pQe+R8Ne4kK75kJtFs=;
        b=QIhP+IKPEdDDA8vwUrShclhCSPImb/WZb31yFXsDcCazdfgBf7FK7YiPVkt9mumnaL
         gb4fx8rcmLWmRXYSWQ+1jket42cDSrSCYvyeVvgdTOA5EAf/C0UV2BXj7J6h7EssNysJ
         VoJi2EtKZqNrsvXQme0jzc5UW0IS34EHoctP2O4UipE2UtFvHxYDeHgI7nsf0eZ5FbOu
         8zE+oKmy3Uhvzltgp4pBxZD2JMWC/cw7lZDl5pcC53owbS9NF/L6WU+s1MMCW/K3LpBk
         5T7r57asE+wnyj9tht7D/Zwr3MmmgqI2iRPCAb648rq8boBziETJYJ/iK1eeYanopUlJ
         jHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yTo2AJFj0p024dmFgNzjlTjj1pQe+R8Ne4kK75kJtFs=;
        b=XE2noFdfbh4CSHo6SOg6JfZ87B3IPuDbGOXKwTHAPkz6JLWwUoLuZbQGt9Pti/dS/A
         4g4q7ddgmSqC21eY5FUf+5OwfuWgT/cBU4CROQ3Yefc+fC1WgxcBUT9uDI+JMq5KDQtB
         54QtF0yteMOEz+ZPJ69rx8GJ5NWWclQ2G9oO8aVuPNtJrHEx7ap8nupkUiRLXPYUfnZH
         WTbbjse4Zcy49E7D/LIAIMhHcXK2pZOQucdfLFp0ImDV791DSin/wWso/NjZ5aTWqYiF
         M+KsTcr1jQTgFCI4gaAaliQlefdN4LtuAVdUYV5M2DKzCM6GlFhIyf4eev4J9iD7m1Q1
         rrzg==
X-Gm-Message-State: AOAM5300AFAkNbxLrGL7LC54MpSmXTJTjrzFHJrr5dKnJhe/UbXxxa9e
        L41OHUTkfVbb7ztzFaz32ucWA6PRaMU=
X-Google-Smtp-Source: ABdhPJz/mYMbyr7MbfGwPFzomgRcKTZAvo6MA2BUHA0IodXKipfENCWl7Nj5w8LVfE3fJU22zp7Rqg==
X-Received: by 2002:a17:906:805:b0:6ce:41a8:113 with SMTP id e5-20020a170906080500b006ce41a80113mr3942484ejd.366.1645740267578;
        Thu, 24 Feb 2022 14:04:27 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id e6-20020a17090681c600b006cea1323f34sm238297ejx.29.2022.02.24.14.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 14:04:27 -0800 (PST)
Date:   Thu, 24 Feb 2022 23:04:22 +0100
From:   Tomasz =?UTF-8?B?V2FybmllxYLFgm8=?= <tomasz.warniello@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/11] Transform documentation into POD
Message-ID: <20220224230422.016cef67@fuji.fritz.box>
In-Reply-To: <87tucokswx.fsf@meer.lwn.net>
References: <20220218181628.1411551-1-tomasz.warniello@gmail.com>
        <87tucokswx.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2022 11:42:38 -0700
Jonathan Corbet <corbet@lwn.net> wrote:

> I have applied the series, thanks.
> 
> jon

Thanks Jon,

T. W.
