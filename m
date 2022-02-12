Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCAC4B38B3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 00:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbiBLXhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 18:37:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbiBLXhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 18:37:37 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D565FF2D;
        Sat, 12 Feb 2022 15:37:32 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id x3-20020a05600c21c300b0037c01ad715bso5487590wmj.2;
        Sat, 12 Feb 2022 15:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H3qL4EvCzkwRh/Z9xEpXSexUuSFqiqriVJEg3zbCkE4=;
        b=KtTOUKpClQMuNg6GgkrINc7OSYQCiT/0VEjxLucHg/Fx5kSl/B3TsEUzoUYPgEzG6Y
         zKR5f176F3djlXqKqkCLY2TV+8Xp8ND+ha/40KCIXodivtldme3KKAuz1zD+k/WlX5En
         sYttZ6L+q1B8MPf+/uJoc+MmFbhjYBN4Um7VEz+haN5PW1wXzL2Kc3qXM0+lruem5uYf
         GHZ2hVSDmz2Sq0/nveGjRAQDJSUwkG8wZxZf7/n/4E3LImrMZQu4crhOGP0TYvXAPSt7
         h4Zjhq1NwbsRU8JMN2YHIT/zLI5js9KLFLMUWbeoJVslseO/z3PN6QyFMsGTqziCvfat
         cspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H3qL4EvCzkwRh/Z9xEpXSexUuSFqiqriVJEg3zbCkE4=;
        b=dTS8vwqiidIX3JTEu2YdAwkhitasvLxhceGrbUE8ydMPH27J9PaEnPd6rpEXItMgjH
         8MtxRGIgYKPVGKWA8lTqy6/mCAMkIwCIWI2GIZRnD7S54K00HrEUVCNh9WCdqGpgOPSm
         +OLRGxNUozTPi0HI8c9hkDm11dg7KLzExLUROXz+8yl51r7UIgby77QhU47Vbd5X92cH
         9tVyu7CJiO+TzFbbjLsiyJsWOhvByBRrCpbQ5XBSDxoQcpMF42WT5woycQL/Z6GEo12f
         1sf6JbdWc/fqTtWhOMRTThZHupDelc+rpEMvVfZd9LXZYgYKDCzU0gKT0VTIO48n+QDd
         f+xA==
X-Gm-Message-State: AOAM5327xtopwYNx5GVKbTrlmRYjTEqLNdeW/vsY+LEYi8WPX2M+TBB2
        gyOxhccbKXUWCgTawNNnhfeIFuKB+SnlAlSN4oIsyW14
X-Google-Smtp-Source: ABdhPJwiauaVYLu/tCgy1jyc/SkzM1Lo5dz3EpoewmbwGRc4XlPyU9qQ6gisjTivTZGEYr9GgVZaiQjld4z493D3QNE=
X-Received: by 2002:a05:600c:4204:: with SMTP id x4mr5245713wmh.123.1644709051504;
 Sat, 12 Feb 2022 15:37:31 -0800 (PST)
MIME-Version: 1.0
References: <20220206022023.376142-1-andrew.smirnov@gmail.com> <YgIu+Lrt0p85yog1@kroah.com>
In-Reply-To: <YgIu+Lrt0p85yog1@kroah.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Sat, 12 Feb 2022 15:37:19 -0800
Message-ID: <CAHQ1cqE_iA0gKmqxS21JMAoFpz-ebhG+axVuUT9P62_JTB9kZQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: Add Steam Deck driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     platform-driver-x86@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 8, 2022 at 12:51 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Feb 05, 2022 at 06:20:23PM -0800, Andrey Smirnov wrote:
> > +#define STEAMDECK_ATTR_RO(_name, _method)                            \
> > +     static ssize_t _name##_show(struct device *dev,                 \
> > +                                 struct device_attribute *attr,      \
> > +                                 char *buf)                          \
> > +     {                                                               \
> > +             struct steamdeck *jup = dev_get_drvdata(dev);           \
> > +             unsigned long long val;                                 \
> > +                                                                     \
> > +             if (ACPI_FAILURE(acpi_evaluate_integer(                 \
> > +                                      jup->adev->handle,             \
> > +                                      _method, NULL, &val)))         \
> > +                     return -EIO;                                    \
> > +                                                                     \
> > +             return sprintf(buf, "%llu\n", val);                     \
>
> Please use sysfs_emit() for this and any other sysfs show functions.
>

Will fix, thanks.

> Also, you have no Documenation/ABI/ entries for all of these new sysfs
> files you are creating.  How do we know what these entries are for, and
> what they contain?  Please add that in future versions of this commit,
> as-is we can't take this :(
>

Yeah, my bad, will add in v2.

>
> > +     }                                                               \
> > +     static DEVICE_ATTR_RO(_name)
> > +
> > +STEAMDECK_ATTR_RO(firmware_version, "PDFW");
> > +STEAMDECK_ATTR_RO(board_id, "BOID");
> > +STEAMDECK_ATTR_RO(pdcs, "PDCS");
> > +
> > +static umode_t
> > +steamdeck_is_visible(struct kobject *kobj, struct attribute *attr, int index)
> > +{
> > +     return attr->mode;
> > +}
>
> As Guenter pointed out, this is not needed.
>

Yup, will drop.

>
> > +
> > +static struct attribute *steamdeck_attributes[] = {
> > +     &dev_attr_target_cpu_temp.attr,
> > +     &dev_attr_gain.attr,
> > +     &dev_attr_ramp_rate.attr,
> > +     &dev_attr_hysteresis.attr,
> > +     &dev_attr_maximum_battery_charge_rate.attr,
> > +     &dev_attr_recalculate.attr,
> > +     &dev_attr_power_cycle_display.attr,
> > +
> > +     &dev_attr_led_brightness.attr,
> > +     &dev_attr_content_adaptive_brightness.attr,
> > +     &dev_attr_gamma_set.attr,
> > +     &dev_attr_display_brightness.attr,
> > +     &dev_attr_ctrl_display.attr,
> > +     &dev_attr_cabc_minimum_brightness.attr,
> > +     &dev_attr_memory_data_access_control.attr,
> > +
> > +     &dev_attr_display_normal_mode_on.attr,
> > +     &dev_attr_display_inversion_off.attr,
> > +     &dev_attr_display_inversion_on.attr,
> > +     &dev_attr_idle_mode_on.attr,
> > +
> > +     &dev_attr_firmware_version.attr,
> > +     &dev_attr_board_id.attr,
> > +     &dev_attr_pdcs.attr,
> > +
> > +     NULL
> > +};
> > +
> > +static const struct attribute_group steamdeck_group = {
> > +     .attrs = steamdeck_attributes,
> > +     .is_visible = steamdeck_is_visible,
> > +};
> > +
> > +static const struct attribute_group *steamdeck_groups[] = {
> > +     &steamdeck_group,
> > +     NULL
> > +};
>
> ATTRIBUTE_GROUPS()?
>

Yes! Thank you.

> thanks,
>
> greg k-h
