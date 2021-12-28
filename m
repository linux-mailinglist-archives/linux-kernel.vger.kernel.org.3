Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CE1480DE0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 00:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237746AbhL1XOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 18:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237737AbhL1XOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 18:14:06 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C336C061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 15:14:06 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id w24so14557564ply.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 15:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Av10FJHZ16PNlaWBwLeHhLYMKvHi/4lm87heoggNDKA=;
        b=avDmmO87bgVuaUHYWdo0zielDmJi9VhHpZprIAY34IQtOhjT0OM25fmEYhLSesc6a3
         R3uToAqwmnIktJoW5nG8z9fF1pV8ODb8yqSRJSyB0mdR0fMYufSLxjzOs1O+uhwXvP6d
         wOWphjHCqJ/IUAf6LxBpIJmsMi0EtHR/t7BFxfZY94Un/e1PPO6Y+WwmjPBUuJozDYr3
         UwDCu6srkV22k1wenTjOkHmCuwRAmzUMdl+d9PljEIbNt/W19dq+JjQn5CUQwEuv85Gh
         zRk1kiJrF2sKrZ4m2Lpl484Bqqcnt5efEF4TMi+9itcc5O7ojtUfC3Vtb1o5ZTbhV2to
         lnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Av10FJHZ16PNlaWBwLeHhLYMKvHi/4lm87heoggNDKA=;
        b=Wh3711B3iyHQpOoJ3FF9DXVBUgqTd+ep5zne0ZM47gpbRjTLJWAtW1WZ//i0UFioBw
         40YGajl81kwGSWL0/jsJ7AZhzHV5jTX0/am5xWZK4XzhpYoihBSv+3gfJpYjLVmO9ucg
         tBOqYx73I9sFfS3ygSS+WVebzh2IRUwf95nrVpRYO7m9yqUj/uTcCnvDnJyfCImO45/x
         /mMk3qWey2lfxwE09+Y2Zon5YvPlW8JkB5X3Q1dHHb981FGAocZ5ts2Jxbcw71RgfFex
         f4ca/2EN6fq/M8tDSlnXzd4bOmOxchsU9GF+6nlyRd22g4nX/5t7olIvLKv0WG/S+ygA
         tSMQ==
X-Gm-Message-State: AOAM530nKWMPTGI5v7EE5Ivc/4Ocs+j3ZeK+odaaeyNZ+dTbs/JBDxni
        kFV8Y8OHcM0taZYny81PVL3UqUJII2rmzzId9hg=
X-Google-Smtp-Source: ABdhPJx0PxZC4pfnoCykSsgCfdLouZOQ/HjotNgmmsipgC9guYQQGIY3KwxceTe3bPQEpRBHd5IyJnRqaBj1t1N3ePc=
X-Received: by 2002:a17:90a:f293:: with SMTP id fs19mr2522261pjb.25.1640733245608;
 Tue, 28 Dec 2021 15:14:05 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a11:390:0:0:0:0 with HTTP; Tue, 28 Dec 2021 15:14:05
 -0800 (PST)
Reply-To: fionahill.usa@hotmail.com
From:   Fiona Hill <tonyelumelu67@gmail.com>
Date:   Tue, 28 Dec 2021 15:14:05 -0800
Message-ID: <CAAVnhxL3vu9xVYMAqQWxFsSwA8UTqz5rUm9rxu-L4zf0BEq5wQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hi, did you receive my message  i send to you?
