Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A816D47D5F7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 18:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbhLVRpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 12:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbhLVRpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 12:45:17 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF67C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 09:45:16 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id i63so5010095lji.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 09:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=QF42aD0zscG+BtuAFRB/mrFD1dxXGx13co8vBNm/8Is=;
        b=hw8gF8Y37JT0pLwaOZRCkYbE0i2cTBRXJBsUPO606G+Khzs+zS6jw7qW3wIDAVZ12N
         t/QvTbJ9oR+HlA+/K3RLCdZ11fzZh9j27tVd9jyLZMjqPNQLS+wEACkGB8yAdd1fcrO0
         VKHuNvNs7Sf+hyqoxSmw8rzmSERCRnZMtJJBd/HCzuGOKZbTA4AZ3rU4r33MTUzLxbk2
         HjLXKuDbkJQhTm/H7SZYrN150qaU85/wFGtxYTSk2pjN+pu/SNNqvJzvPkYIGuvGmR3i
         yazlwLaspfImM/bk2fVk+IZkR/CfzdvgRSTLvazEpWNHhkGChlcF0u8852T9VrcqGLPA
         XaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=QF42aD0zscG+BtuAFRB/mrFD1dxXGx13co8vBNm/8Is=;
        b=yNVzblQyPwVHa8x5TUDem5414k2tiI7/pJOF+WY9fObhHHPGfo7EJB18Ipsq5JDeTc
         A7kZ542hTOLwDqNsDVHl5u+yqzNSyIFjXISNfD72PPtuApPU7FjPEuwu67dRRx+BKBDX
         w/1E1+EAW3kZhVnQWVKPMu+0nfyIg6Nt+kxSy/NR/98MVcxX0+PdAKK9IzO639l2ec2f
         QyuMeMlA7KmNljSwzxPaATLsaL/bASHzfJwC32/HpT9fVbUspnKp0lsfiKwSrKEroPJs
         L80KHn6rvHR5tZ0Iya7M5EX00zzKPsb58DczQRyWg4QvF/7vk2S4fDHOqR8olR4gU41J
         q03A==
X-Gm-Message-State: AOAM5327KGETLMcR41FH1i0T2AR9x7Ips+g1J8+6ktr+MB/GqlFzXHkU
        2RdOljVkbDeIRmfWzT8/MxRqIvoYLfqooplYUzk=
X-Google-Smtp-Source: ABdhPJwLQ3PNJsZMJTvCg38igSUBPam5TXvv0vJXkTSmP0XgoWoMHiL6wwhgKE+9tv5JwdIriHmVChw9dYHfr15GQTY=
X-Received: by 2002:a2e:96d0:: with SMTP id d16mr2013285ljj.330.1640195115046;
 Wed, 22 Dec 2021 09:45:15 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a2e:88ca:0:0:0:0:0 with HTTP; Wed, 22 Dec 2021 09:45:13
 -0800 (PST)
Reply-To: camillejackson021@gmail.com
In-Reply-To: <CA+gc9O5Z96TZcX+TSP0-WR_zsMKSjMuWigidv3Lrhs4qK5Wi1g@mail.gmail.com>
References: <CA+gc9O5Z96TZcX+TSP0-WR_zsMKSjMuWigidv3Lrhs4qK5Wi1g@mail.gmail.com>
From:   camille jackson <aminoutchanile@gmail.com>
Date:   Wed, 22 Dec 2021 17:45:13 +0000
Message-ID: <CA+gc9O4BnctTefa7BME0ra=-S41f5QjnjEDiLp8vK-4XFyiHMQ@mail.gmail.com>
Subject: Pozdravy
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SmFrIHNlIGRuZXMgbcOhxaEsIGRvdWbDoW0sIMW+ZSBzZSBtw6HFoSBkb2LFmWUsIHByb3PDrW0g
b2Rwb3bEm3ogbWkgdGXEjywgZMOta3kNCg==
