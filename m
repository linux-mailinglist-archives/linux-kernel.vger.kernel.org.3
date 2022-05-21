Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB3A52FC4D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 14:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354363AbiEUMHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 08:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238596AbiEUMG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 08:06:56 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF26366A6
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 05:06:54 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id a23-20020a17090acb9700b001df4e9f4870so9835267pju.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 05:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XOxK0GZTG3zYkcVVIz/tjC8b+nMMdPNdYaC1uHgulmg=;
        b=cLlFPBA7LKFbuNteDXM/Ni5gcCSWkLFLbWThl8P7vJ3mk++xLUT4Q3WQIGAryBxjY7
         YGEJkip6/wx0DT0jV+UgKgQ3lAd7X7t7lSdvUOu0TfSaqPZcGIKQmmCg0iAd1cDu0QWb
         1sRaeRlGXQ9lA3pVX18udLrUZB196WgYGAtdjW8Zu5P29ent9e+BV8x6ObT4u4JmtEWm
         npRMdTc8x7PMtfZQQ1JpW6TH7l+PrMAYyqVqdlJjQKlvo5ddL675g0o2trW/KZzF3XUR
         zAJyuf0n9TeZEE1/PL//EtlpQ38ol2ovoKW9QxOxzD4j77ml//cac5HXZ8Th9R972k66
         0Kig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XOxK0GZTG3zYkcVVIz/tjC8b+nMMdPNdYaC1uHgulmg=;
        b=non9M9Gt14LvrahbjETmoDa8pcyGt5SY3aUULfAh5Te5YGz7OTAZkQuWuB3shE0v48
         v+XDW7V+lzsWPL4knK+tCNasHhivibGdoMreRoZm6A26rtG1F5n96aKMaZEWllJwhzVd
         hoINCsSnpn1MRVMNpsCl/oLN7HnYbsHsgcRvauS8DUaqAW7chK+xbM+yEoSooo2g5OHo
         vqawvrxcQ+RguZi5koPRBVTd0eHOTAFiN9AvTczlW+Hu9DjpYqmJUNi2IzBJr+KLEXqY
         4ru2WzUklRk3L8ftXbI/DCM5+BnMQ1G7SFCA86DNUS/dOtu5JYqWd7D8hhITqWkgD4t1
         ZC7Q==
X-Gm-Message-State: AOAM532S9o/eIeHeEpyMUXB7FbW4zslICFt73FHzNb/wMrW8bgtIOcox
        YB6SI7FfmKAfF8Omo0N3sezgGg==
X-Google-Smtp-Source: ABdhPJxUfkJQDODwjG5WeDkaRuJF0E4A7lcddfUZ9xKoHPZapNAa14RROOwglDBP6qGMwA748aydHA==
X-Received: by 2002:a17:902:bb85:b0:161:556f:7782 with SMTP id m5-20020a170902bb8500b00161556f7782mr14481930pls.10.1653134813995;
        Sat, 21 May 2022 05:06:53 -0700 (PDT)
Received: from localhost ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id i198-20020a6287cf000000b005180c127200sm3596875pfe.24.2022.05.21.05.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 05:06:53 -0700 (PDT)
Date:   Sat, 21 May 2022 20:06:50 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kernel-janitors@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/vm/pkeys: fix typo in comment
Message-ID: <YojV2iAMAzTYhHOp@FVFYT0MHHV2J.usts.net>
References: <20220521111145.81697-80-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521111145.81697-80-Julia.Lawall@inria.fr>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 01:11:30PM +0200, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
 
