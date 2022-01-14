Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86B248EC33
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242156AbiANPHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:07:25 -0500
Received: from mail-4022.proton.ch ([185.70.40.22]:27141 "EHLO
        mail-4022.proton.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235794AbiANPHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:07:25 -0500
Date:   Fri, 14 Jan 2022 15:07:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1642172842;
        bh=eLKKiTMw1JJZ+1oGczRJs+/VLcUyP4uYFpIUjpFZWFE=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=QciLqLZNzaO+Dq8ITPa2PPVLKwvF21lT3mUdWYucI1U2ztgVfZJDUdCVStKlmA0ko
         7b/iE8UyPIOzG0tD5RFUqJxnkODP2Nqe6Cd3w1TBrcmWB88XbrENAXfatPg/wPcuQd
         GH9LZ/lbfTSMkkk87uIdu9QTYXGCHzA5KvdRC+D+FG+L4sNgOkmkCOt0McLDKhXeN9
         dFQPiOs22ncnZuRc7bgx5w//jcgh8eETic48bpSJARO/EUC1m/egpi3h7P0S0aKKUo
         s+SS8RDLFLVWI6/DfPssJFi4fiVYK6cbRY81vZe7hm4aQnIaS89o3DnxWNLBteTTuS
         ZpKjLjFpPwSjA==
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     Tomohito Esaki <etom@igel.co.jp>, dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ben Skeggs <bskeggs@redhat.com>,
        =?utf-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Mark Yacoub <markyacoub@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Evan Quan <evan.quan@amd.com>, Petr Mladek <pmladek@suse.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org, Daniel Stone <daniel@fooishbar.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Damian Hobson-Garcia <dhobsong@igel.co.jp>,
        Takanari Hayama <taki@igel.co.jp>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [RFC PATCH v3 2/3] drm: add support modifiers for drivers whose planes only support linear layout
Message-ID: <7eljcd3F4aWL2jjBRwr3DISmyt0XPWFIH1_kebFGqZTJXLZRx0bm_8c8yaIuEuH8rS0MaJhU6SY1y-fc6U_zCLaKgoLM124nZpr0H91nSjw=@emersion.fr>
In-Reply-To: <YeGFugZvwbF7l2I/@smile.fi.intel.com>
References: <20220114101753.24996-1-etom@igel.co.jp> <20220114101753.24996-3-etom@igel.co.jp> <YeGFugZvwbF7l2I/@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, January 14th, 2022 at 15:16, Andy Shevchenko <andriy.shevchenko@=
linux.intel.com> wrote:

> Why not enum?

There is no enum for DRM format modifiers.
