Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEE849048A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 10:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbiAQJCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 04:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbiAQJCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 04:02:10 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F860C06173F;
        Mon, 17 Jan 2022 01:02:08 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p18so18707740wmg.4;
        Mon, 17 Jan 2022 01:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=pKQyE8WmRVKRRSfCnHXiQ2iVbjjWgAi/p8fAcfN9+Bw=;
        b=YffBhN651/Z0BklBOyvA5ZOyGu8rIBJ8+YLlWg9M5uzMmi3n/Ak+YV9GY055jAmx71
         jd/YTSomGNRGaf7STMxfmc+MUVl/vNg5HUCaqfi8thzuZvr08jlzhVo+ra2zq8ZTMhYX
         0GaNUMsAh/p2ww0u5GsePmMY5qI5AQ0lSPDLNiMlg9cRqp7nYNUX+nENOeHvw0bKxEsU
         1LpRSC0G0L1X8JsfrlTkHQ7Ib8bPiUuUzvlZP4L3R+F+o2QyyOqSSPjMSZ5wKmi8MPjE
         ojYQVV/sbjRl9UGzxDug3wohHgwKdYsuCYgOHLAJIGasNTTX85gbMtJeKU7zv041mW8Y
         EKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=pKQyE8WmRVKRRSfCnHXiQ2iVbjjWgAi/p8fAcfN9+Bw=;
        b=KG0Q89WRqnbYUsBDWd0q76V5T3+U+BclrmUUtec2bmTIhj1+G4FIzeTqlsUo2mn64b
         MBfHcRxZXUd+M5ig5tKFg5mDhb3XkXcJvdhjttyFHo/sKkkEzcAPlVnhve5/n5pFaztm
         U39Ipir++clrnqbuIB78ZoUZPB37qCHJlUHo2pOSLqTkugy11D2EuVzcH7MLMWKGiqXi
         VHpTHHXykuE1xiAY/FzY0TqIV8V3UD/Lan3jyfTOOc1NWTmxLoHzpto7losoSAauZpix
         c7SCM4G/98NuUc2n3zCv02OqshK+RU5UV+1JP3xW/wTBW0KE59hDmwZ9VOJmRMnZy7Gv
         cyJg==
X-Gm-Message-State: AOAM5330SPNxl03FcDCUz7QIwe+qHdzpauIJMbEaQqdJnNFxd/ApfJAA
        7tkhBo6ehyC0ujOn4YwOdKE=
X-Google-Smtp-Source: ABdhPJzSDquw+wIa3NNFcJih60Yz+qeM+h3FbVeoZHjlghC05OVNb9akOnxnKBfuR2cLfo0iwApWcQ==
X-Received: by 2002:a5d:6dd1:: with SMTP id d17mr19500538wrz.520.1642410127168;
        Mon, 17 Jan 2022 01:02:07 -0800 (PST)
Received: from ubuntu-laptop (p4fd59309.dip0.t-ipconnect.de. [79.213.147.9])
        by smtp.googlemail.com with ESMTPSA id f9sm14810512wry.115.2022.01.17.01.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 01:02:06 -0800 (PST)
Message-ID: <ea4c2c5b0495b3ee1a637a59f6ff5da754d8a8b3.camel@gmail.com>
Subject: Re: [PATCH v2] scsi: ufs: ufshcd-pltfrm: check the return value of
 devm_kstrdup()
From:   Bean Huo <huobean@gmail.com>
To:     xkernel.wang@foxmail.com, bvanassche@acm.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 17 Jan 2022 10:02:05 +0100
In-Reply-To: <tencent_4257E15D4A94FF9020DDCC4BB9B21C041408@qq.com>
References: <tencent_4257E15D4A94FF9020DDCC4BB9B21C041408@qq.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-01-16 at 11:06 +0800, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> 
> 
> devm_kstrdup() returns pointer to allocated string on success,
> 
> NULL on failure. So it is better to check the return value of it.
> 
> 
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>

