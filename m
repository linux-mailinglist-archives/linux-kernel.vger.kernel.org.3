Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30A147AC4E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 15:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbhLTOmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 09:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbhLTOlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 09:41:32 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCDFC0613A5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 06:41:02 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id b188-20020a1c80c5000000b00345afe7e3c0so189592wmd.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 06:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=UtoF0r4yG8U/T8UOLxn8dacSd49m7zi2Qvhr7fGOaoo=;
        b=keW6P0RbCpoRsfn3xReLqcOtyi34ZTJa9l0vzZp7+m4HnGsU3C7lMbErZcG3UOTEz0
         BcgV9nzudfIkuSLybOAWHVbuv4io5tSJL9/S8XgpTOhhiEZImozI9KMpT0Uxoa0zPT9V
         bhcvDYthO5OfvPhqqkJSot1ICRErc7p2ioSPzYQvjPyA387uJniZimo4Y5rfn2jKgmj1
         2sjvXsD5vLC5zLE0qckwst5ZloKVnQdyZ0qf8HBdRD+M9Ef1Dxkg+llH7COAsoCT7w11
         D/0Dl8YEYVM419sycsbJgS8SdWi6Fg79VWeWfYpS9MkeWu+RjIv62Uz+4nC9KU1+yGWl
         CBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=UtoF0r4yG8U/T8UOLxn8dacSd49m7zi2Qvhr7fGOaoo=;
        b=1iIX5ZBkq5nJ8QeW1JTQz9VbPjYP2z9zbgda6Q87l8/WQu0qD1lV5B6OnpT442uVzZ
         2S7qOCWjJFvwEaaGs0hKmtuUm8uoY8zN1Zn5grs2u+TqqVbdw2HNSxH/VrOWjQrow/Tx
         wC/AxpcZrdG8T2GrnQVB8uShZEtYXMmMmBEhCkG9bS1u3FLPMLfXjuc6borTvHHlPXWA
         /DU58AVFPnposH5/2QKVknrYzd5F0mbwflT9faGVM3uZn5mz/h8lBoNIDiHjSwid3RxU
         QvvWw+wSOfhnO/I360jCaVIAWWTGe240xFR7JyXKaz+vdXXzC63oJNUXLjndtLw+Wy+h
         cuhA==
X-Gm-Message-State: AOAM532Kd447mk1cxrXgc3k5/uRHTNebAbs6JnwcLFkpqhD+TECOo81m
        1D+WgtRa+yBZhyWpJGT//nRY1oafDlDQag==
X-Google-Smtp-Source: ABdhPJw/n/ntl5tb67zMT2iP5wtIZ9+VwNMS01axIfCLM6/M425NZagvrnOI9IZTdVSwvkyrfNlJpg==
X-Received: by 2002:a05:600c:3b12:: with SMTP id m18mr3728976wms.54.1640011260973;
        Mon, 20 Dec 2021 06:41:00 -0800 (PST)
Received: from [192.168.9.102] ([129.205.112.56])
        by smtp.gmail.com with ESMTPSA id f6sm1931036wmq.6.2021.12.20.06.40.57
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 20 Dec 2021 06:41:00 -0800 (PST)
Message-ID: <61c095fc.1c69fb81.90088.96e1@mx.google.com>
From:   Margaret Leung KO May-y <jogbodo12@gmail.com>
X-Google-Original-From: Margaret Leung KO May-y
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?q?Gesch=C3=A4ftsvorschlag?=
To:     Recipients <Margaret@vger.kernel.org>
Date:   Mon, 20 Dec 2021 15:40:53 +0100
Reply-To: la67737777@gmail.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bin Frau Margaret Leung Ich habe einen Gesch=E4ftsvorschlag f=FCr Sie, erre=
ichen Sie mich unter: la67737777@gmail.com

Margaret Leung
Managing Director of Chong Hing Bank
