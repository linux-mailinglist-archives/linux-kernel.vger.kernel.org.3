Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307614AFC02
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 19:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbiBISwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 13:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241275AbiBISu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 13:50:57 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D813C0613C9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 10:47:03 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id w11so5658235wra.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 10:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=WwV9i83hTOoSW63e4AGIE+PjEYBZlZU9PGy3pEkJj6E=;
        b=B1az+FnfjJOpMBpX5Il3jM5MRY7Xiqh91CiUeSeCfk5TdHo54SPgHOfbPqBau2TbON
         u/wHnGx2vmR2xJu5iIpY981SaE2nC0lTetSWk33od3X0WWDDNICqQAFtdKCHSec4N1K9
         5gzxers77piVNiI5rzJ4L+o1AuKyP4B8BfSPSzW+3MU/9JA094NaM12zHH6q7FlywlBp
         X3VDn6QBqBF/s2MPW/ElW5VEBzAKzRFhSJ8h8XsW+6ftEwVz2ck73I5yTT8H2oZQbYb/
         Kcx2xIJvoxaD7BwT+07d08WuOlqi1NcZ97Ne7CNEzcHeXwEZA14elHczsGxoHk0myqjs
         /E5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=WwV9i83hTOoSW63e4AGIE+PjEYBZlZU9PGy3pEkJj6E=;
        b=GwCFh9sljvHyffAV+8aNMiJ9giRdbT38FQhtLWo+7nkJg+YOib8pnWCGQ/7aZaaZgG
         Mi2ktbTsi0j27uq8S9os8LU6/26D2Xsah93tzDnp5zYhQmaJf8w5b29jnSDsNxcoN0i1
         xdA9voae2ZOKcPSzrddaA33F84paCryiZ/XjPlY286wN/Vr+Nyt9uvWqvFiU98Ddty3W
         fbIgfv/bjXjWwc2hAQARu7VuwE6KYxDKLFH8DD3jnkXA0nbCyUEi6L5ydi5SkJSnR8V6
         JHb4cOKYdqzCbNlDsdT3B0NXmKkTGJ4QxlJBpKZigEKQD4BAEM0j/YTRv6YbSnhK2QlM
         Hhpw==
X-Gm-Message-State: AOAM530ZDzqFc3CT/oIoiwgNixKMQxJt3H1rJHkL+uBZuIX7mG82H/2R
        HpSTxfrI2EAcgkYebDzn7JDisxVa70jVtvp71oQ=
X-Google-Smtp-Source: ABdhPJzS33K/TPTsZLbk4xoMVhpc24DPQ+X8dtHboedOUiT4thvh5ySgBZ6KhouyUDxALeNrE70V6zFReQ0CWdqItR0=
X-Received: by 2002:adf:e344:: with SMTP id n4mr3248388wrj.630.1644432421940;
 Wed, 09 Feb 2022 10:47:01 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a5d:59ae:0:0:0:0:0 with HTTP; Wed, 9 Feb 2022 10:47:01 -0800 (PST)
Reply-To: borowskishirley@gmail.com
From:   Borowski Shirley <ibitoyebami@gmail.com>
Date:   Wed, 9 Feb 2022 19:47:01 +0100
Message-ID: <CAOk47ije9BYNjJJN+koTciEkV-Eg_k2t+mYtP8P3bzvXmV8aag@mail.gmail.com>
Subject: reply
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Please get back to me urgently ,

Mr.Borowski Shirley.
borowskishirley@gmail.com
